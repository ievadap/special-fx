using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SeeThroughOnEnter : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        if (other.name != "Player") return;

        Color color = GetComponent<Renderer>().material.color;
        color.a = 0f;
        GetComponent<Renderer>().material.SetColor("_Color", color);
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.name != "Player") return;

        Color color = GetComponent<Renderer>().material.color;
        color.a = 1f;
        GetComponent<Renderer>().material.SetColor("_Color", color);
    }
}
