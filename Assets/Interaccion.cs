using System;
using UnityEngine;

public class Interaccion : MonoBehaviour
{
    [SerializeField] private GameObject Button;

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            Button.SetActive(true);
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            Button.SetActive(false);
        }
    }
}
