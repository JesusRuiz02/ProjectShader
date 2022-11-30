using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightHouseController : MonoBehaviour
{
    [SerializeField] private float speed = 20;
    [SerializeField] private bool interruptor = true;
    void Update()
    {
        if (interruptor)
        {
            transform.Rotate(0,0,1*Time.deltaTime * speed );
        }
    }

    public void Toogle()
    {
        interruptor =! interruptor;
    }
}

