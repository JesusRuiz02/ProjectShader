using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeTexture : MonoBehaviour
{
    [SerializeField] private Material[] _materials;
    [SerializeField] private MeshRenderer meshRenderer;
    void Start()
    {
        meshRenderer = GetComponent<MeshRenderer>();
        StartCoroutine(Materiales());
    }

    private IEnumerator Materiales()
    {
        while (true)
        {
            foreach (Material VARIABLE in _materials)
            {
               meshRenderer.material = VARIABLE;
                yield return new WaitForSeconds(6f);
            }
        }
    }
}
