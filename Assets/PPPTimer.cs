using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class PPPTimer : MonoBehaviour
{
    Bloom bloomLayer;
    private void Update() {
        PostProcessVolume volume = gameObject.GetComponent<PostProcessVolume>();
        volume.profile.TryGetSettings(out bloomLayer);
        bloomLayer.intensity.value = Mathf.PingPong(Time.time, 1) * 20;
    }
}
