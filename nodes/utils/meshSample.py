import sys
import numpy as np
import trimesh
import json

def barycentric_to_cartesian(barycentric_coordinates, triangle):
    """
    Returns cartesian coordinates from barycentric coordinates.
    Triangle must be 3xP with P the dim of the triangle. This supports broadcasting
    """
    return np.dot(triangle, barycentric_coordinates)

def sample_face(selection):
    """
    Samples points from a given face
    """
    triangle, nb_sample = selection
    if nb_sample == 0:
        return []
    # random barycentric coordinates for each face
    random_baryentric_coordinates = np.random.random([nb_sample, 3])
    norm = np.sum(random_baryentric_coordinates, axis=1)
    random_baryentric_coordinates = random_baryentric_coordinates / np.stack([norm, norm, norm], axis=1)  # N*3
    # pass into euclidian coordinates
    samples = barycentric_to_cartesian(triangle, random_baryentric_coordinates)
    return samples

def compute_triangle_area(triangle):
    """
    A utility function to calculate compute_triangle_area
    of triangle T:(A:(x1, y1),B:(x2, y2),C:(x3, y3)) where x and y are vectors.
    A, B or C may be a single point or an array of points, you can try to broadcast as well.
    Triangle can be a 3xT or 3xNxT, whith N the dimention of te triangle and T the number of triangles
    """
    if isinstance(triangle, list):
        N=len(triangle[0])
    else:
        N = triangle.shape[1]
    if N == 2:  # 2D case, support multiple triangles
        (x1, y1), (x2, y2), (x3, y3) = triangle
        area = abs((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / 2.0)
    else:  # triangle in N dims
        A, B, C = triangle
        AB = np.transpose(np.asarray(B) - np.asarray(A))  # vector AB
        BC = np.transpose(np.asarray(C) - np.asarray(B))  # vector BC both should broadcast
        area = abs(np.sum(np.cross(AB, BC), axis=1)) / N  # ABC = 1/2 |ABxBC|
    return area

def random_sample_points_mesh(mesh, target_nb_samples):
    """
    Randomly samples points on the surface of a mesh.
    Returns an array of size nb_samplesx3
    """
    vertices, faces = mesh.vertices, mesh.faces
    triangles = vertices[faces]
    # compute triangle area
    faces_areas = compute_triangle_area(np.transpose(triangles, [1, 2, 0]))
    # normalise
    faces_areas /= np.sum(faces_areas)
    #get a list of random faces to draw from, big faces are more likely to be drawn
    #formaly: sampling faces from a discrete probability distribution proportioanl to its area
    faces_to_samples = np.random.choice(list(range(triangles.shape[0])), target_nb_samples, p=faces_areas)
    #draw random barycentric coordinates
    random_baryentric_coordinates = np.random.random([target_nb_samples, 3])
    norm = np.sum(random_baryentric_coordinates, axis=1)
    random_baryentric_coordinates = random_baryentric_coordinates / np.stack([norm, norm, norm], axis=1)  # N*3
    # pass into euclidian coordinates for each of the selected face
    samples = []
    for sample_nb, (triangle_index, bary_coordinates) in enumerate(zip(faces_to_samples, random_baryentric_coordinates)):
        print("Sample %d/%d"%(sample_nb,target_nb_samples))
        sample = barycentric_to_cartesian(triangles[triangle_index], bary_coordinates)
        samples.append(sample)
    return np.stack(samples, axis=0)

print("*Hello")

print("**Loading mesh")
mesh = trimesh.load(sys.argv[1], force='mesh')

nb_samples = int(sys.argv[2])
sfm_data = json.load(open(sys.argv[3], "r"))

print("**Sampling")
samples = random_sample_points_mesh(mesh, nb_samples)
samples[:,1]*=-1
samples[:,2]*=-1

print("**Formatting")
structure = []
views_id = [v["viewId"] for v in sfm_data["views"]]
for vi, v in enumerate(samples):  
    landmark = {}
    landmark["landmarkId"] = str(vi)
    landmark["descType"] = "unknown" 
    landmark["color"] = ["255", "0", "0"]
    landmark["X"] = [str(x) for x in v]
    landmark["observations"] = []
    #create dummy obs in all views 
    for oi, i in enumerate(views_id):
        obs =  {"observationId": str(i),
                "featureId": str(oi),
                "x": [0,0]}
        landmark["observations"].append(obs)
    structure.append(landmark)
sfm_data["structure"] = structure

# Save the generated SFM data to JSON file
print("**Writting sfm")
with open(sys.argv[4], 'w') as f:
    json.dump(sfm_data, f, indent=4)
