Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web09.1431.1627942176992259494
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Aug 2021 15:09:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.183.197, mailfrom: foss@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPA id CCC231C0003;
	Mon,  2 Aug 2021 22:09:34 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 03 Aug 2021 00:09:34 +0200
From: "Quentin Schulz" <foss@0leil.net>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 3/4] doc/lib: Add fixes for issues missed by the automated conversion
In-Reply-To: <20210730134706.3360651-3-richard.purdie@linuxfoundation.org>
References: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
 <20210730134706.3360651-3-richard.purdie@linuxfoundation.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <249e08c0bda32c45a6ed1de71638bb36@0leil.net>
X-Sender: foss@0leil.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Richard,

On 2021-07-30 15:47, Richard Purdie wrote:
> The examples and tests use non-standard override names, convert these 
> to
> the new syntax by hand.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
[...]

I can suggest the following additional changes. Please note that there 
are two sections for which I have doubts about their correctness. They 
are preceded by a FIXME FIXME FIXME comment that can (should) easily be 
removable after applying this diff with `patch`.

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst 
b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 6b88fd11..b0494d08 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -325,14 +325,14 @@ Surrounding spaces and spacing are preserved. Here 
is an example::
  The variable ``FOO`` becomes
  "  789 123456    " and ``FOO2`` becomes "    abcdef     ".

-Like "_append" and "_prepend", "_remove" is applied at variable
+Like ":append" and ":prepend", ":remove" is applied at variable
  expansion time.

  Override Style Operation Advantages
  -----------------------------------

-An advantage of the override style operations "_append", "_prepend", 
and
-"_remove" as compared to the "+=" and "=+" operators is that the
+An advantage of the override style operations ":append", ":prepend", 
and
+":remove" as compared to the "+=" and "=+" operators is that the
  override style operators provide guaranteed operations. For example,
  consider a class ``foo.bbclass`` that needs to add the value "val" to
  the variable ``FOO``, and a recipe that uses ``foo.bbclass`` as 
follows::
@@ -347,14 +347,14 @@ not what is desired::
     FOO += "val"

  If, on the other hand, ``foo.bbclass``
-uses the "_append" operator, then the final value of ``FOO`` will be
+uses the ":append" operator, then the final value of ``FOO`` will be
  "initial val", as intended::

     FOO:append = " val"

  .. note::

-   It is never necessary to use "+=" together with "_append". The 
following
+   It is never necessary to use "+=" together with ":append". The 
following
     sequence of assignments appends "barbaz" to FOO::

         FOO:append = "bar"
@@ -379,8 +379,8 @@ You can find more out about variable flags in 
general in the
  You can define, append, and prepend values to variable flags. All the
  standard syntax operations previously mentioned work for variable flags
-except for override style syntax (i.e. "_prepend", "_append", and
-"_remove").
+except for override style syntax (i.e. ":prepend", ":append", and
+":remove").

  Here are some examples showing how to set variable flags::

@@ -581,7 +581,7 @@ variable.
     ``do_compile`` task.

     You can also use this syntax with other combinations (e.g.
-   "``_prepend``") as shown in the following example::
+   "``:prepend``") as shown in the following example::

        EXTRA_OEMAKE:prepend:task-compile = "${PARALLEL_MAKE} "

@@ -613,7 +613,7 @@ users.

  There is often confusion concerning the order in which overrides and
  various "append" operators take effect. Recall that an append or 
prepend
-operation using "_append" and "_prepend" does not result in an 
immediate
+operation using ":append" and ":prepend" does not result in an 
immediate
  assignment as would "+=", ".=", "=+", or "=.". Consider the following
  example::

@@ -671,7 +671,7 @@ For this case, the type of append
  operators are affecting the order of assignments as BitBake passes
  through the code multiple times. Initially, ``A`` is set to "1 45"
  because of the three statements that use immediate operators. After
-these assignments are made, BitBake applies the "_append" operations.
+these assignments are made, BitBake applies the ":append" operations.
  Those operations result in ``A`` becoming "1 4523".

  Sharing Functionality
@@ -908,7 +908,7 @@ rules. The scripts are executed by ``/bin/sh``, 
which may not be a bash
  shell but might be something such as ``dash``. You should not use
  Bash-specific script (bashisms).
-Overrides and override-style operators like ``_append`` and 
``_prepend``
+Overrides and override-style operators like ``:append`` and 
``:prepend``
  can also be applied to shell functions. Most commonly, this application
  would be used in a ``.bbappend`` file to modify functions in the main
  recipe. It can also be used to modify functions inherited from classes.
@@ -1135,7 +1135,7 @@ equivalent to the following snippet::
  values set for the variables within the anonymous functions become
  available to tasks, which always run after parsing.

-Overrides and override-style operators such as "``_append``" are 
applied
+Overrides and override-style operators such as "``:append``" are 
applied
  before anonymous functions run. In the following example, ``FOO`` ends
  up with the value "foo from anonymous"::

@@ -1165,7 +1165,7 @@ To understand the benefits of this feature, 
consider the basic scenario
  where a class defines a task function and your recipe inherits the
  class. In this basic scenario, your recipe inherits the task function 
as
  defined in the class. If desired, your recipe can add to the start and
-end of the function by using the "_prepend" or "_append" operations
+end of the function by using the ":prepend" or ":append" operations
  respectively, or it can redefine the function completely. However, if 
it
  redefines the function, there is no means for it to call the class
  version of the function. ``EXPORT_FUNCTIONS`` provides a mechanism that
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 60aaf390..46ce78a6 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1146,9 +1146,10 @@ def srcrev_internal_helper(ud, d, name):
      pn = d.getVar("PN")
      attempts = []
      if name != '' and pn:
-        attempts.append("SRCREV_%s_pn-%s" % (name, pn))
+        #FIXME FIXME FIXME not sure about the SRCREV_%s to SRCREV:%s 
change
+        attempts.append("SRCREV:%s:pn-%s" % (name, pn))
      if name != '':
-        attempts.append("SRCREV_%s" % name)
+        attempts.append("SRCREV:%s" % name)
      if pn:
          attempts.append("SRCREV:pn-%s" % pn)
      attempts.append("SRCREV")
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 1b6b6d41..4d17f82e 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -99,7 +99,7 @@ exportD = "d"

      overridetest = """
  RRECOMMENDS:${PN} = "a"
-RRECOMMENDS:${PN}_libc = "b"
+RRECOMMENDS:${PN}:libc = "b"
  OVERRIDES = "libc:${PN}"
  PN = "gtk+"
  """
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 6ba1d2a3..e6e82d11 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1178,7 +1178,7 @@ def edit_metadata(meta_lines, variables, varfunc, 
match_overrides=False):
          variables: a list of variable names to look for. Functions
              may also be specified, but must be specified with '()' at
              the end of the name. Note that the function doesn't have
-            any intrinsic understanding of _append, _prepend, _remove,
+            any intrinsic understanding of :append, :prepend, :remove,
              or overrides, so these are considered as part of the name.
              These values go into a regular expression, so regular
              expression syntax is allowed.
diff --git a/lib/toaster/toastergui/views.py 
b/lib/toaster/toastergui/views.py
index 04ab8bcb..34afacc1 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1839,6 +1839,7 @@ if True:
          except ProjectVariable.DoesNotExist:
              pass
          try:
+            #FIXME FIXME FIXME Is this correct? it could also be 
image_install_append_defined or image_install:append:defined
              context['image_install:append'] =  
ProjectVariable.objects.get(project = prj, name = 
"IMAGE_INSTALL:append").value
              context['image_install:append_defined'] = "1"
          except ProjectVariable.DoesNotExist:

--------
Cheers,
Quentin
