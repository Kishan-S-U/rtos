This document describes the features and functionalities of a simple multitasking operating system implemented for mc68000 microprocessor, which is simulated in the easy68k simulator.

Multitasking and Time Slicing
-
<img src="../res/rtos structure.jpg" align="center"/>
The main objective of this feature is to allow multiple tasks to run in parallel by sharing the processor time equally between the tasks. The image above describes the design used.

Memory Layout
-
<img src="../res/rtos memory layout.jpg" align="center"/>
The main operating system starts from the bottom of the memory, this runs in the foreground (when any interrupt occurs). The TCBs (Task Control Blocks) are at the very top, right below the default stack pointer. The free area in memory is used for memory allocation, mostly assigned to specific tasks upon request, for data storage.

Startup Behaviour
-
The following steps explain the startup behaviour;
1. initializing all the necessary variables to its default values.
2. All the TCBs, except for the first one, are marked as unused.
3. The beginning of the user code is considered as the default ‘task 0’, so the first TCB is initialized with values related to ‘task 0’.
4. Mutex is marked as available.

User Functions
-
These are specific functions, implemented in the operating system, that can be used for various purposes. These functions are described below;
- Create Task: This functions will initialize new task and add it to the 'ready list' [a list maintained by the OS of the ongoing tasks]. Example code,
  ```
  t0:
    move.l  #syscr,d0
    move.l  #t1,d1
    move.l  #$4000,d2
    trap    #sys
  ```
  #syscr: represents the system call code to create a task. <br />
  t1: label of the new task <br />
  d0: holds the function to run. <br />
  d1, d2: parameter <br />
  #$4000: is the task’s stack size. <br />
  #sys:  a software interrupt is raised to run the OS. <br />

- Delete Task: The objective of this function is to remove a task from the ready list, such that it will not execute any further. In this system, if any task has to stop execution then the task itself must request the OS to do so. Example code,
  ```
  move.l  #sysdel,d0
  trap    #sys
  ```

- Wait Mutex: This function is requested when a task needs an access to a shared resource. The OS maintains a variable to hold the status of the shared resource and this function will check and allocate the permission to access that resource, in case permission is denied (another task is using the resource) the requesting task will be put to the waiting list. Example code,
  ```
  move.l  #syswtmx,d0
  trap    #sys
  ```

- Signal Mutex: The main objective of this system is to free the shared resource. The mutex variable in the OS will be adjusted accordingly and in case of any task in waiting list, the shared resource access will be given to it in priority. Example code,
  ```
  move.l  #syssgmx,d0
  trap    #sys
  ```

- Initialize Mutex: This function can be used to change the state of the mutex variable (internal variable in OS). Example code,
  ```
  move.l  #sysinmx,d0
  move.l  #1,d1
  trap    #sys
  ```
  d1: holds the required state of the mutex variable (user specified)

- Wait Timer: The main objective of this function is to hold the execution of any task for the specified clock cycles. Example code,
  ```
  move.l  #syswtmx,d0
  move.l  #3,d1
  trap    #sys
  ```
  d1: holds the number of clock cycles to wait

- Wait I/O: This function holds the execution of any specified task until an I/O interrupt occurs (waiting for the I/O operation to complete).
  ```
  move.l  #syswtio,d0
  trap    #sys
  ```
