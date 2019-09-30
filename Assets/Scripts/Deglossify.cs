using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Deglossify : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        if (other.name != "Player") return;
        GetComponent<Renderer>().material.SetFloat("_Glossiness", 0f);
    }
    private void OnTriggerExit(Collider other)
    {
        if (other.name != "Player") return;
        GetComponent<Renderer>().material.SetFloat("_Glossiness", 1f);
    }
}
