using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SeeThroughOnEnter : MonoBehaviour
{
    private bool isTriggered = false;
    private new Renderer renderer;
    private void Start() 
    {
        renderer = GetComponent<Renderer>();
    }
    private void Update() 
    {
        animateTransparency();
    }
    private void animateTransparency()
    {
        if (isTriggered) return;
        float alpha = Mathf.PingPong(Time.time, 1.0f);
        renderer.material.SetColor("_Color", colorWithAlpha(alpha)); 
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.name != "Player") return;
        isTriggered = true;
        renderer.material.SetColor("_Color", colorWithAlpha(0));
    }
    private void OnTriggerExit(Collider other)
    {
        if (other.name != "Player") return;
        isTriggered = false;
        renderer.material.SetColor("_Color", colorWithAlpha(1));
    }
    private Color colorWithAlpha(float alpha) 
    {
        Color color = renderer.material.color;
        color.a = alpha;
        return color;
    }
}
