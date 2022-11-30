using System;
using UnityEngine;

public class ReturnPlanet : MonoBehaviour
{
    [SerializeField] private GameObject[] Planeta;

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            for (int i = 0; i < Planeta.Length; i++)
            {
                Planeta[i].GetComponent<Galaxy>().cambiarBool(false);
            }
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            for (int i = 0; i < Planeta.Length; i++)
            {
                Planeta[i].GetComponent<Galaxy>().cambiarBool(true);
            }
        }
    }
}
