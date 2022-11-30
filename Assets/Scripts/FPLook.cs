using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FPLook : MonoBehaviour
{
    [SerializeField] private float sensitivity;
    [SerializeField] private bool inverted;
    Transform character;
    Vector2 rotation;

    void Start()
    {
        character = GetComponentInParent<FPMovement>().transform;
    }

    void Update()
    {
        rotation.y += Input.GetAxis("Mouse X");
        rotation.x += -Input.GetAxis("Mouse Y");
        if(inverted != true)
        {
            rotation.x += -Input.GetAxis("Mouse Y");
        }
        else
        {
            rotation.x += Input.GetAxis("Mouse Y");

        }
        rotation.x = Mathf.Clamp(rotation.x, -15, 15);
        character.eulerAngles = new Vector2(0, rotation.y) * sensitivity;
        transform.localRotation = Quaternion.Euler(rotation.x * sensitivity, 0, 0);
    }
}
