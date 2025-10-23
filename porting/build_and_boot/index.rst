Building and booting
====================

Now it's time to download and configure the necessary source code.
Then we'll build it and get it to boot.
Firstly follow the **Building** steps for your Halium version and porting method.
Secondly, proceed with the final **Install and boot** section.


Building
--------

.. toctree::
   :maxdepth: 1

   standalone_kernel_build
   standalone_kernel_install
   Boot_debug


.. _deprecated-building-methods:

Deprecated building methods
===========================

In the past there used to be three separate porting methods called:

- Full system image method
- Halium boot method
- Standalone kernel method

For modern devices, this is much simplified. Full system was only really applicable on Halium 7.1 and 9.0 and Halium-boot worked on Halium 9.0. Nowadays there is just The One method that's described in this porting guide and what used to be called "Standalone method".
If you are interested in the historic details feel free to read about the good ol' ways `in the git history. <https://gitlab.com/ubports/docs/docs.ubports.com/-/tree/porting-in-three-methods>`_
