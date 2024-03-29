﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionKick : MonoBehaviour
{
    public float forceMultiplier = 100;

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.name == "Player")
        {
            Vector3 force = forceMultiplier * collision.relativeVelocity;
            gameObject.GetComponent<Rigidbody>().AddForce(force);
        }
    }
}
