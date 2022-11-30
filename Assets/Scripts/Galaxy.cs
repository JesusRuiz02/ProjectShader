using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Galaxy : MonoBehaviour
{
    public float timeCounter = 0;
    public float speed = 0.0f;
    public float width = 0.0f;
    public float height = 0.0f;
    public bool Rotation = true;
    private Vector3 startvalue = default;

    private void Start()
    {
        startvalue = transform.position;
        Rotation = true;
    }
    void Update()
    {
        if (Rotation)
        {
            timeCounter += Time.deltaTime * speed;
            float x = Mathf.Cos(timeCounter) * width;
            float z = Mathf.Sin(timeCounter) * height;
            float y = 50;
            transform.position = new Vector3(x, y, z);   
        }
        else
        {
            transform.position = startvalue;
        }
    }

    public void cambiarBool(bool valor)
    {
        Rotation = valor;
    }
}

