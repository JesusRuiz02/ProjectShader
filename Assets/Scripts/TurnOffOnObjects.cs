using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TurnOffOnObjects : MonoBehaviour
{
    [SerializeField] private GameObject oceanObject;
    [SerializeField] private GameObject helmetObject;
    public bool oceanToogle = true;
    public bool helmetToogle = true;

    private void ObjectToogle(GameObject shaderObject, bool value)
    {
        shaderObject.SetActive(value);
    }

    public void HelmetToogle()
    {
        helmetToogle = !helmetToogle;
       ObjectToogle(helmetObject, helmetToogle);
    }
    public void OceanToogle()
    {
        oceanToogle = !oceanToogle;
        ObjectToogle(oceanObject, oceanToogle);
    }
}
