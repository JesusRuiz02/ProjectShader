using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FPMovement : MonoBehaviour
{
    [SerializeField] private float moveSpeed;
    private bool grounded;

    private float stepOffset;
    [SerializeField] private float jumpHeight;
    [SerializeField] private float gravity;

    public LayerMask groundMask;
    CharacterController controller;
    Vector3 movement;
    Vector3 velocity;

    void Start()
    {
        controller = GetComponent<CharacterController>();
      //  stepOffset = controller.stepOffset;
    }

    void Update()
    {
        RaycastHit hit;
        grounded = Physics.Raycast(transform.position, -transform.up, out hit, .1f, groundMask);
        if(grounded == true && velocity.y < 0)
        {
            velocity.y = -1f;
        }
        if(grounded != true)
        {
            controller.stepOffset = 0;
        }
        else
        {
            controller.stepOffset = stepOffset;
        }
        Vector2 axis = new Vector2(Input.GetAxis("Horizontal"), Input.GetAxis("Vertical"));

        movement = transform.right * axis.x + transform.forward * axis.y;
        controller.Move(movement * moveSpeed * Time.deltaTime);

        if (Input.GetButtonDown("Jump") && grounded == true)
        {
            velocity.y = Mathf.Sqrt(jumpHeight * -2 * gravity);
        }
        if(velocity.y > -10)
        {
            velocity.y += gravity * Time.deltaTime;
        }
        controller.Move(velocity * Time.deltaTime);
    }
}
