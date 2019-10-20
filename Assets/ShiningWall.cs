using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShiningWall : MonoBehaviour
{   
    private Material mainMaterial;
    public Transform Player;
    public float revealDistance;
    void Start() {
        mainMaterial = gameObject.GetComponent<MeshRenderer>().material;
    }

    void Update() {
        float distance = Vector3.Distance(transform.position, Player.position);
        mainMaterial.SetFloat("_Blend", Mathf.Clamp01(distance / revealDistance));
    }
}
