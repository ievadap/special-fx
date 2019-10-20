using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SeeThroughOnEnter : MonoBehaviour
{
    private new Renderer renderer;
    private void Start() 
    {
        renderer = GetComponent<Renderer>();
    }
    private void Update() 
    {
        animateEmissionIntensity();
    }
    private void animateEmissionIntensity()
    {
        float emission = Mathf.PingPong(Time.time, 2.0f) + 0.5f;
        Color baseColor = renderer.material.color; 
        Color finalColor = baseColor * Mathf.LinearToGammaSpace(emission);
        renderer.material.SetColor("_EmissionColor", finalColor); 
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.name != "Player") return;
        renderer.material.SetColor("_Color", colorWithAlpha(0));
    }
    private void OnTriggerExit(Collider other)
    {
        if (other.name != "Player") return;
        renderer.material.SetColor("_Color", colorWithAlpha(1));
    }
    private Color colorWithAlpha(float alpha) 
    {
        Color color = renderer.material.color;
        color.a = alpha;
        return color;
    }
}
