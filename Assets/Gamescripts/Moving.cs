using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Moving : MonoBehaviour
{
    Rigidbody body;


    public float speed;
    private float boost = 3;
    float duration = 3;


    // Start is called before the first frame update
    void Start()
    {
       body = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
        
    {
        //Will Only contain the basic moving and boosting with D being move the bike and a being apply the boost until duraction is gone. The map is just a couple jumps with only one lane due to my limited programing skills and wanting to use most of the time to shaders.
      
        
        if (Input.GetKey(KeyCode.D))
        {
            body.AddForce(transform.right * speed);

        }


        if (duration > 0)
        {
            if (Input.GetKey(KeyCode.A))
            {
                body.AddForce(transform.right * (speed + boost));
                duration = -1;
            }
        }

        if(duration == 0)
        {
           speed = speed/2;
        }

    }
}
