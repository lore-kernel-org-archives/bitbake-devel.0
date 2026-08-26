Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E613C61DC7
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 01:37:23 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3437.1787708233848207054
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 18:37:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=eW8YgS04;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92edb12cdf2so23191685a.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 18:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787708233; x=1788313033; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJAI4gbP4KQjRT4wLKrGXW+Aqt+Lpicisi4grc9e62s=;
        b=eW8YgS04EcdWPwoTmXFEQstAWPYGNNoSeZ7jztstEuQ/+mj3LiEmkNrq2+T4pbSUjl
         7X6Ps8yyUJpo6s+bg7oTNUUo10BSRRyg+FgO9g8bVkio9iuuBn+IPlt5qQao4N0NViR+
         S30N77U3mO8FxUQfWzS4gSeRKtKH2V2f5IIiDK918sriBHduc4dDOQjrYqWO+oUFhdYs
         UYLikxH0zvPLsxpRZIdlKJ7qieh/rF3A8yEL590L9MttDhBsuEBVvv2KdGpYUoDUqn7z
         79rRqjwVCE+1mQMjbUm3EDkkvn6ok6Hjh1Qd2RaGhq5LA5w0dwjjtAoDzH71Ipn/vuzC
         G7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787708233; x=1788313033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HJAI4gbP4KQjRT4wLKrGXW+Aqt+Lpicisi4grc9e62s=;
        b=PvJFA/yCjcVGm22WXuwlS/T00g7Tkxh4Vc/C/y7MKzDZuiQNHkiJAvZyOSwz9R+lcd
         Or5poejdYKH5H+74lA6Z0WVWG9TqSbvyzsC2FWMRKh40AzFzTzUPYWQoI+ohCM/BSqVC
         /Q3a5kCaJONyVbnKIdL4hEHkwzEctY3TpCGuXn81Cta+meIC1pss/bcL+V1DeJs29chG
         R583yCWSDHNb52/dWh+7VoGFAO9HFcyN/2+baQlISNntujuAFOZGLOAIKbisFlICZupZ
         N5c2ZTCZugI3A/43+haSYoRBRhnW/FZTx865ngwidQUibRR1p4VIjQwDp3Y/Em7BC14I
         0hqA==
X-Gm-Message-State: AFuF++lD1RWi2UqEII2xqph6WvoN0Rfs2+DfnGrLmReJaDLj+8/CdPwy
	jwtRdpF5olEcbAyA0GG40Ve5L57C7ot/ZI/frC5uLa9YbO9YYwBtA1QQ
X-Gm-Gg: AR+sD10ONvFpDe0Cc34g2DUv49oSIPXbmepHPCB5zBh9K2KuJS+TOjM4TLgu6hwOIT5
	nvA5OFPpRwHzUlXZO4Mg5Oon0rbbSFbDm6XAVROtN2xphEKpN+89MnKlYIV6F0jWD9aIoa48LdO
	s4ZfaOgLox5YK6R5WD80lP+VPZmL4WtYyds26oKXzJwnJS3yznMtt01LXW76id0mbSLm562YgAk
	BTyoRA7DBzD3aGOGhPFb+SLFwpKaYgIAuRN7+WvU91NLsVGsEPbzDqrNDULFz334Mnsl88rURiR
	bIqRWAeEfc+n37SvWlc+chBCN2bkCM5hPeUYZGsa9s1/oP1tL3CZt8LPhUicYBi+PZeuLCzNGnz
	udxSSIePR1wnbO0hYNRTEjzJ4tdVZTZJemBtBsFY1NaNvJ3+66RyFLvXkJCfPhcRDv7snlAbes/
	RcprixlNHXH632WEc00swUqGbywAbGXQ/tmDnZ7wvSBVdKVtjU4+5SkrM6mPPH150vZuZKkH/lq
	ocw8bBVlN2QZxvPnDdMDKAfo6E2HYc=
X-Received: by 2002:a05:620a:1b84:b0:937:6772:d8d with SMTP id af79cd13be357-93780162998mr326679485a.20.1787708231274;
        Tue, 25 Aug 2026 18:37:11 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e67c50esm103863685a.37.2026.08.25.18.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 18:37:09 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: docs@lists.yoctoproject.org
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/4] doc: bitbake-user-manual-metadata: use the bitbake code-block language
Date: Tue, 25 Aug 2026 21:37:00 -0400
Message-ID: <20260826013703.2674786-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260826013703.2674786-1-twoerner@gmail.com>
References: <20260826013703.2674786-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 01:37:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20051

BitBake snippets here render as unhighlighted text. A reStructuredText
literal block carries no language, and Sphinx falls back to a default
that cannot recognise BitBake metadata.

Pygments 2.21 added a BitBake lexer, so tag these 95 blocks
explicitly. Variable names, assignment operators, override chains,
expansions and shell or Python task bodies are then highlighted.

The syntax chapter is where the language itself is described, so almost
every example in it is BitBake.

AI-Generated: codex/claude-opus 5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../bitbake-user-manual-metadata.rst          | 372 +++++++++++++-----
 1 file changed, 279 insertions(+), 93 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index a146b897c884..08534a8681b4 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -21,26 +21,34 @@ Basic Variable Setting
 
 The following example sets ``VARIABLE`` to "value". This assignment
 occurs immediately as the statement is parsed. It is a "hard"
-assignment. ::
+assignment.
+
+.. code-block:: bitbake
 
    VARIABLE = "value"
 
 As expected, if you include leading or
-trailing spaces as part of an assignment, the spaces are retained::
+trailing spaces as part of an assignment, the spaces are retained:
+
+.. code-block:: bitbake
 
    VARIABLE = " value"
    VARIABLE = "value "
 
 Setting ``VARIABLE`` to "" sets
 it to an empty string, while setting the variable to " " sets it to a
-blank space (i.e. these are not the same values). ::
+blank space (i.e. these are not the same values).
+
+.. code-block:: bitbake
 
    VARIABLE = ""
    VARIABLE = " "
 
 You can use single quotes instead of double quotes when setting a
 variable's value. Doing so allows you to use values that contain the
-double quote character::
+double quote character:
+
+.. code-block:: bitbake
 
    VARIABLE = 'I have a " in my value'
 
@@ -106,7 +114,9 @@ Outside of :ref:`functions <bitbake-user-manual/bitbake-user-manual-metadata:fun
 BitBake joins any line ending in
 a backslash character ("\\") with the following line before parsing
 statements. The most common use for the "\\" character is to split
-variable assignments over multiple lines, as in the following example::
+variable assignments over multiple lines, as in the following example:
+
+.. code-block:: bitbake
 
    FOO = "bar \
           baz \
@@ -117,7 +127,9 @@ character that follow it are removed when joining lines. Thus, no
 newline characters end up in the value of ``FOO``.
 
 Consider this additional example where the two assignments both assign
-"barbaz" to ``FOO``::
+"barbaz" to ``FOO``:
+
+.. code-block:: bitbake
 
    FOO = "barbaz"
    FOO = "bar\
@@ -136,7 +148,9 @@ Variable Expansion
 Variables can reference the contents of other variables using a syntax
 that is similar to variable expansion in Bourne shells. The following
 assignments result in A containing "aval" and B evaluating to
-"preavalpost". ::
+"preavalpost".
+
+.. code-block:: bitbake
 
    A = "aval"
    B = "pre${A}post"
@@ -150,7 +164,9 @@ The "=" operator does not immediately expand variable references in the
 right-hand side. Instead, expansion is deferred until the variable
 assigned to is actually used. The result depends on the current values
 of the referenced variables. The following example should clarify this
-behavior::
+behavior:
+
+.. code-block:: bitbake
 
    A = "${B} baz"
    B = "${C} bar"
@@ -168,7 +184,9 @@ expansion (:=)` operator.
 If the variable expansion syntax is used on a variable that does not
 exist, the string is kept as is. For example, given the following
 assignment, ``BAR`` expands to the literal string "${FOO}" as long as
-``FOO`` does not exist. ::
+``FOO`` does not exist.
+
+.. code-block:: bitbake
 
    BAR = "${FOO}"
 
@@ -178,7 +196,9 @@ Setting a default value (?=)
 You can use the "?=" operator to achieve a "softer" assignment for a
 variable. This type of assignment allows you to define a variable if it
 is undefined when the statement is parsed, but to leave the value alone
-if the variable has a value. Here is an example::
+if the variable has a value. Here is an example:
+
+.. code-block:: bitbake
 
    A ?= "aval"
 
@@ -198,7 +218,9 @@ Setting a weak default value (??=)
 The weak default value of a variable is the value which that variable
 will expand to if no value has been assigned to it via any of the other
 assignment operators. The "??=" operator takes effect immediately, replacing
-any previously defined weak default value. Here is an example::
+any previously defined weak default value. Here is an example:
+
+.. code-block:: bitbake
 
    W ??= "x"
    A := "${W}" # Immediate variable expansion
@@ -208,7 +230,9 @@ any previously defined weak default value. Here is an example::
    C = "${W}"
    W ?= "i"
 
-After parsing we will have::
+After parsing we will have:
+
+.. code-block:: bitbake
 
    A = "x"
    B = "y"
@@ -216,22 +240,30 @@ After parsing we will have::
    W = "i"
 
 Appending and prepending non-override style will not substitute the weak
-default value, which means that after parsing::
+default value, which means that after parsing:
+
+.. code-block:: bitbake
 
    W ??= "x"
    W += "y"
 
-we will have::
+we will have:
+
+.. code-block:: bitbake
 
    W = " y"
 
 On the other hand, override-style appends/prepends/removes are applied after
-any active weak default value has been substituted::
+any active weak default value has been substituted:
+
+.. code-block:: bitbake
 
    W ??= "x"
    W:append = "y"
 
-After parsing we will have::
+After parsing we will have:
+
+.. code-block:: bitbake
 
    W = "xy"
 
@@ -239,7 +271,9 @@ Immediate variable expansion (:=)
 ---------------------------------
 
 The ":=" operator results in a variable's contents being expanded
-immediately, rather than when the variable is actually used::
+immediately, rather than when the variable is actually used:
+
+.. code-block:: bitbake
 
    T = "123"
    A := "test ${T}"
@@ -265,7 +299,9 @@ the "+=" and "=+" operators. These operators insert a space between the
 current value and prepended or appended value.
 
 These operators take immediate effect during parsing. Here are some
-examples::
+examples:
+
+.. code-block:: bitbake
 
    B = "bval"
    B += "additionaldata"
@@ -284,7 +320,9 @@ If you want to append or prepend values without an inserted space, use
 the ".=" and "=." operators.
 
 These operators take immediate effect during parsing. Here are some
-examples::
+examples:
+
+.. code-block:: bitbake
 
    B = "bval"
    B .= "additionaldata"
@@ -302,7 +340,9 @@ style syntax. When you use this syntax, no spaces are inserted.
 
 These operators differ from the ":=", ".=", "=.", "+=", and "=+"
 operators in that their effects are applied at variable expansion time
-rather than being immediately applied. Here are some examples::
+rather than being immediately applied. Here are some examples:
+
+.. code-block:: bitbake
 
    B = "bval"
    B:append = " additional data"
@@ -338,7 +378,9 @@ value to be removed from the variable. Unlike ":append" and ":prepend",
 there is no need to add a leading or trailing space to the value.
 
 When you use this syntax, BitBake expects one or more strings.
-Surrounding spaces and spacing are preserved. Here is an example::
+Surrounding spaces and spacing are preserved. Here is an example:
+
+.. code-block:: bitbake
 
    FOO = "123 456 789 123456 123 456 123 456"
    FOO:remove = "123"
@@ -362,7 +404,9 @@ expansion time.
    This implies it is not possible to re-append previously removed strings.
    However, one can undo a ":remove" by using an intermediate variable whose
    content is passed to the ":remove" so that modifying the intermediate
-   variable equals to keeping the string in::
+   variable equals to keeping the string in:
+
+   .. code-block:: bitbake
 
      FOOREMOVE = "123 456 789"
      FOO:remove = "${FOOREMOVE}"
@@ -385,27 +429,35 @@ An advantage of the override style operations ":append", ":prepend", and
 ":remove" as compared to the "+=" and "=+" operators is that the
 override style operators provide guaranteed operations. For example,
 consider a class ``foo.bbclass`` that needs to add the value "val" to
-the variable ``FOO``, and a recipe that uses ``foo.bbclass`` as follows::
+the variable ``FOO``, and a recipe that uses ``foo.bbclass`` as follows:
+
+.. code-block:: bitbake
 
    inherit foo
    FOO = "initial"
 
 If ``foo.bbclass`` uses the "+=" operator,
 as follows, then the final value of ``FOO`` will be "initial", which is
-not what is desired::
+not what is desired:
+
+.. code-block:: bitbake
 
    FOO += "val"
 
 If, on the other hand, ``foo.bbclass``
 uses the ":append" operator, then the final value of ``FOO`` will be
-"initial val", as intended::
+"initial val", as intended:
+
+.. code-block:: bitbake
 
    FOO:append = " val"
 
 .. note::
 
    It is never necessary to use "+=" together with ":append". The following
-   sequence of assignments appends "barbaz" to FOO::
+   sequence of assignments appends "barbaz" to FOO:
+
+   .. code-block:: bitbake
 
        FOO:append = "bar"
        FOO:append = "baz"
@@ -432,7 +484,9 @@ standard syntax operations previously mentioned work for variable flags
 except for override style syntax (i.e. ":prepend", ":append", and
 ":remove").
 
-Here are some examples showing how to set variable flags::
+Here are some examples showing how to set variable flags:
+
+.. code-block:: bitbake
 
    FOO[a] = "abc"
    FOO[b] = "123"
@@ -444,7 +498,9 @@ respectively. The ``[a]`` flag becomes "abc 456".
 
 No need exists to pre-define variable flags. You can simply start using
 them. One extremely common application is to attach some brief
-documentation to a BitBake variable as follows::
+documentation to a BitBake variable as follows:
+
+.. code-block:: bitbake
 
    CACHE[doc] = "The directory holding the cache of the metadata."
 
@@ -458,7 +514,9 @@ Inline Python Variable Expansion
 --------------------------------
 
 You can use inline Python variable expansion to set variables. Here is
-an example::
+an example:
+
+.. code-block:: bitbake
 
    DATE = "${@time.strftime('%Y%m%d',time.gmtime())}"
 
@@ -467,7 +525,9 @@ This example results in the ``DATE`` variable being set to the current date.
 Probably the most common use of this feature is to extract the value of
 variables from BitBake's internal data dictionary, ``d``. The following
 lines select the values of a package name and its version number,
-respectively::
+respectively:
+
+.. code-block:: bitbake
 
    PN = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"
    PV = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
@@ -476,12 +536,16 @@ respectively::
 
    Inline Python expressions work just like variable expansions insofar as the
    "=" and ":=" operators are concerned. Given the following assignment, foo()
-   is called each time FOO is expanded::
+   is called each time FOO is expanded:
+
+   .. code-block:: bitbake
 
       FOO = "${@foo()}"
 
    Contrast this with the following immediate assignment, where foo() is only
-   called once, while the assignment is parsed::
+   called once, while the assignment is parsed:
+
+   .. code-block:: bitbake
 
       FOO := "${@foo()}"
 
@@ -509,7 +573,9 @@ When specifying pathnames for use with BitBake, do not use the tilde
 cause BitBake to not recognize the path since BitBake does not expand
 this character in the same way a shell would.
 
-Instead, provide a fuller path as the following example illustrates::
+Instead, provide a fuller path as the following example illustrates:
+
+.. code-block:: bitbake
 
    BBLAYERS ?= " \
        /home/scott-lenovo/LayerA \
@@ -520,7 +586,9 @@ Exporting Variables to the Environment
 
 You can export variables to the environment of running tasks by using
 the ``export`` keyword. For example, in the following example, the
-``do_foo`` task prints "value from the environment" when run::
+``do_foo`` task prints "value from the environment" when run:
+
+.. code-block:: bitbake
 
    export ENV_VARIABLE
    ENV_VARIABLE = "value from the environment"
@@ -538,7 +606,9 @@ It does not matter whether ``export ENV_VARIABLE`` appears before or
 after assignments to ``ENV_VARIABLE``.
 
 It is also possible to combine ``export`` with setting a value for the
-variable. Here is an example::
+variable. Here is an example:
+
+.. code-block:: bitbake
 
    export ENV_VARIABLE = "variable-value"
 
@@ -575,7 +645,9 @@ variable.
    to satisfy conditions. Thus, if you have a variable that is
    conditional on "arm", and "arm" is in :term:`OVERRIDES`, then the
    "arm"-specific version of the variable is used rather than the
-   non-conditional version. Here is an example::
+   non-conditional version. Here is an example:
+
+   .. code-block:: bitbake
 
       OVERRIDES = "architecture:os:machine"
       TEST = "default"
@@ -592,7 +664,9 @@ variable.
    an OpenEmbedded metadata-based Linux kernel recipe file. The
    following lines from the recipe file first set the kernel branch
    variable ``KBRANCH`` to a default value, then conditionally override
-   that value based on the architecture of the build::
+   that value based on the architecture of the build:
+
+   .. code-block:: bitbake
 
       KBRANCH = "standard/base"
       KBRANCH:qemuarm = "standard/arm-versatile-926ejs"
@@ -604,7 +678,9 @@ variable.
 
 -  *Appending and Prepending:* BitBake also supports append and prepend
    operations to variable values based on whether a specific item is
-   listed in :term:`OVERRIDES`. Here is an example::
+   listed in :term:`OVERRIDES`. Here is an example:
+
+   .. code-block:: bitbake
 
       DEPENDS = "glibc ncurses"
       OVERRIDES = "machine:local"
@@ -614,14 +690,18 @@ variable.
 
    Again, using an OpenEmbedded metadata-based kernel recipe file as an
    example, the following lines will conditionally append to the
-   ``KERNEL_FEATURES`` variable based on the architecture::
+   ``KERNEL_FEATURES`` variable based on the architecture:
+
+   .. code-block:: bitbake
 
       KERNEL_FEATURES:append = " ${KERNEL_EXTRA_FEATURES}"
       KERNEL_FEATURES:append:qemux86 = " cfg/sound.scc cfg/paravirt_kvm.scc"
       KERNEL_FEATURES:append:qemux86-64 = " cfg/sound.scc cfg/paravirt_kvm.scc"
 
 -  *Setting a Variable for a Single Task:* BitBake supports setting a
-   variable just for the duration of a single task. Here is an example::
+   variable just for the duration of a single task. Here is an example:
+
+   .. code-block:: bitbake
 
       FOO:task-configure = "val 1"
       FOO:task-compile = "val 2"
@@ -637,7 +717,9 @@ variable.
    ``do_compile`` task.
 
    You can also use this syntax with other combinations (e.g.
-   "``:prepend``") as shown in the following example::
+   "``:prepend``") as shown in the following example:
+
+   .. code-block:: bitbake
 
       EXTRA_OEMAKE:prepend:task-compile = "${PARALLEL_MAKE} "
 
@@ -655,7 +737,9 @@ Key Expansion
 -------------
 
 Key expansion happens when the BitBake datastore is finalized. To better
-understand this, consider the following example::
+understand this, consider the following example:
+
+.. code-block:: bitbake
 
    A${B} = "X"
    B = "2"
@@ -681,7 +765,9 @@ There is often confusion concerning the order in which overrides and
 various "append" operators take effect. Recall that an append or prepend
 operation using ":append" and ":prepend" does not result in an immediate
 assignment as would "+=", ".=", "=+", or "=.". Consider the following
-example::
+example:
+
+.. code-block:: bitbake
 
    OVERRIDES = "foo"
    A = "Z"
@@ -698,7 +784,9 @@ Applying overrides, however, changes things. Since "foo" is listed in
 version, which is equal to "X". So effectively, ``A:foo`` replaces
 ``A``.
 
-This next example changes the order of the override and the append::
+This next example changes the order of the override and the append:
+
+.. code-block:: bitbake
 
    OVERRIDES = "foo"
    A = "Z"
@@ -711,7 +799,9 @@ appended with "X". Consequently, ``A`` becomes "ZX". Notice that spaces
 are not appended.
 
 This next example has the order of the appends and overrides reversed
-back as in the first example::
+back as in the first example:
+
+.. code-block:: bitbake
 
    OVERRIDES = "foo"
    A = "Y"
@@ -725,7 +815,9 @@ leaving the variable set to "ZX". Finally, applying the override for
 "foo" results in the conditional variable ``A`` becoming "ZX" (i.e.
 ``A`` is replaced with ``A:foo``).
 
-This final example mixes in some varying operators::
+This final example mixes in some varying operators:
+
+.. code-block:: bitbake
 
    A = "1"
    A:append = "2"
@@ -781,7 +873,9 @@ file and then have your recipe inherit that class file.
 
 As an example, your recipes could use the following directive to inherit
 an ``autotools.bbclass`` file. The class file would contain common
-functionality for using Autotools that could be shared across recipes::
+functionality for using Autotools that could be shared across recipes:
+
+.. code-block:: bitbake
 
    inherit autotools
 
@@ -795,7 +889,9 @@ In this case, BitBake would search for the directory
 
 If you want to use the directive to inherit multiple classes, separate
 them with spaces. The following example shows how to inherit both the
-``buildhistory`` and ``rm_work`` classes::
+``buildhistory`` and ``rm_work`` classes:
+
+.. code-block:: bitbake
 
    inherit buildhistory rm_work
 
@@ -825,12 +921,16 @@ This allows conditional expressions to be evaluated "late", meaning changes to
 the variable after the line is parsed will take effect. With the :ref:`inherit
 <ref-bitbake-user-manual-metadata-inherit>` directive this is not the case.
 
-Here is an example::
+Here is an example:
+
+.. code-block:: bitbake
 
    inherit_defer ${VARNAME}
 
 One way to achieve a conditional inherit in this case is to use
-overrides::
+overrides:
+
+.. code-block:: bitbake
 
    VARNAME = ""
    VARNAME:someoverride = "myclass"
@@ -841,11 +941,15 @@ parsing. Assuming ``someoverride`` is in :term:`OVERRIDES`, ``${VARNAME}``
 expands to ``myclass``, which is then inherited.
 
 Alternatively, you could use an inline Python expression in the
-following form::
+following form:
+
+.. code-block:: bitbake
 
    inherit_defer ${@'classname' if condition else ''}
 
-Or::
+Or:
+
+.. code-block:: bitbake
 
    inherit_defer ${@bb.utils.contains('VARIABLE', 'something', 'classname', '', d)}
 
@@ -876,7 +980,9 @@ encapsulated functionality or configuration that does not suit a
 ``.bbclass`` file.
 
 For example, if you needed a recipe to include some self-test definitions,
-you might write::
+you might write:
+
+.. code-block:: bitbake
 
    include test_defs.inc
 
@@ -917,7 +1023,9 @@ As a realistic example of this directive, imagine that all of your active
 layers contain a file ``conf/distro/include/maintainers.inc``, containing
 maintainer information for the recipes in that layer, and you wanted to
 collect all of the content from all of those files across all of those layers.
-You could use the statement::
+You could use the statement:
+
+.. code-block:: bitbake
 
    include_all conf/distro/include/maintainers.inc
 
@@ -958,7 +1066,9 @@ include file named ``foo.inc`` that contains the common definitions
 needed to build "foo". You need to be sure ``foo.inc`` is located in the
 same directory as your two recipe files as well. Once these conditions
 are set up, you can share the functionality using a ``require``
-directive from within each recipe::
+directive from within each recipe:
+
+.. code-block:: bitbake
 
    require foo.inc
 
@@ -971,7 +1081,9 @@ class. BitBake only supports this directive when used within a
 configuration file.
 
 As an example, suppose you needed to inherit a class file called
-``abc.bbclass`` from a configuration file as follows::
+``abc.bbclass`` from a configuration file as follows:
+
+.. code-block:: bitbake
 
    INHERIT += "abc"
 
@@ -989,7 +1101,9 @@ subdirectory in one of the directories specified in :term:`BBPATH`.
 If you want to use the directive to inherit multiple classes, you can
 provide them on the same line in the ``local.conf`` file. Use spaces to
 separate the classes. The following example shows how to inherit both
-the ``autotools`` and ``pkgconfig`` classes::
+the ``autotools`` and ``pkgconfig`` classes:
+
+.. code-block:: bitbake
 
    INHERIT += "autotools pkgconfig"
 
@@ -1016,7 +1130,9 @@ go into ``bitbake.conf``, for example::
 -  name of variable that contains definitions for built-in fragments
 
 This allows listing enabled configuration fragments in ``OE_FRAGMENTS``
-variable like this::
+variable like this:
+
+.. code-block:: bitbake
 
    OE_FRAGMENTS = "core/domain/somefragment core/someotherfragment anotherlayer/anotherdomain/anotherfragment"
 
@@ -1025,13 +1141,17 @@ where a fragment file is located, defined by :term:`BBFILE_COLLECTIONS` in ``lay
 
 The implementation then expands this list into
 :ref:`require <bitbake-user-manual/bitbake-user-manual-metadata:\`\`require\`\` directive>`
-directives with full paths to respective layers::
+directives with full paths to respective layers:
+
+.. code-block:: bitbake
 
    require /path/to/core-layer/conf/fragments/domain/somefragment.conf
    require /path/to/core-layer/conf/fragments/someotherfragment.conf
    require /path/to/another-layer/conf/fragments/anotherdomain/anotherfragment.conf
 
-The variable containing a list of fragment metadata variables could look like this::
+The variable containing a list of fragment metadata variables could look like this:
+
+.. code-block:: bitbake
 
    OE_FRAGMENTS_METADATA_VARS = "BB_CONF_FRAGMENT_SUMMARY BB_CONF_FRAGMENT_DESCRIPTION"
 
@@ -1039,16 +1159,22 @@ The implementation will add a flag containing the fragment name to each of those
 when parsing fragments, so that the variables are namespaced by fragment name, and do not override
 each other when several fragments are enabled.
 
-The variable containing a built-in fragment definitions could look like this::
+The variable containing a built-in fragment definitions could look like this:
+
+.. code-block:: bitbake
 
    OE_FRAGMENTS_BUILTIN = "someprefix:SOMEVARIABLE anotherprefix:ANOTHERVARIABLE"
 
 and then if 'someprefix/somevalue' is added to the variable that holds the list
-of enabled fragments::
+of enabled fragments:
+
+.. code-block:: bitbake
 
    OE_FRAGMENTS = "... someprefix/somevalue"
 
-bitbake will treat that as direct value assignment in its configuration::
+bitbake will treat that as direct value assignment in its configuration:
+
+.. code-block:: bitbake
 
    SOMEVARIABLE = "somevalue"
 
@@ -1067,7 +1193,9 @@ BitBake also uses the :term:`BBPATH` variable.
 For these two directives, BitBake includes the first file it finds.
 
 Let's consider the following statement called from a recipe file located in
-``/layers/meta-custom2/recipes-example/example/example_0.1.bb``::
+``/layers/meta-custom2/recipes-example/example/example_0.1.bb``:
+
+.. code-block:: bitbake
 
    require myfile.inc
 
@@ -1084,7 +1212,9 @@ And let's assume that the value of :term:`BBPATH` is
 In this case the first path of the list matches and BitBake includes this file
 in ``example_0.1.bb``.
 
-Another common example would be::
+Another common example would be:
+
+.. code-block:: bitbake
 
    require recipes-other/other/otherfile.inc
 
@@ -1101,7 +1231,9 @@ This time, the second item of this list would be matched.
 
 Note that the first path is based on the location of the file with the
 ``require`` (or ``include``) directive. Imagine there's a
-``/layers/meta-custom2/recipes-bbappend/example/example_0.1.bbappend`` with::
+``/layers/meta-custom2/recipes-bbappend/example/example_0.1.bbappend`` with:
+
+.. code-block:: bitbake
 
    require myappend.inc
 
@@ -1120,7 +1252,9 @@ It is also possible to include *all* occurences of a file with the same name
 with the :ref:`include_all <ref-include-all-directive>` directive.
 
 Let's consider the following statement called from a recipe file located in
-``/layers/meta-custom2/recipes-example/example/exampleall_0.1.bb``::
+``/layers/meta-custom2/recipes-example/example/exampleall_0.1.bb``:
+
+.. code-block:: bitbake
 
    include_all all.inc
 
@@ -1213,7 +1347,9 @@ Shell Functions
 
 Functions written in shell script are executed either directly as
 functions, tasks, or both. They can also be called by other shell
-functions. Here is an example shell function definition::
+functions. Here is an example shell function definition:
+
+.. code-block:: bitbake
 
    some_function () {
        echo "Hello World"
@@ -1232,7 +1368,9 @@ can also be applied to shell functions. Most commonly, this application
 would be used in a ``.bbappend`` file to modify functions in the main
 recipe. It can also be used to modify functions inherited from classes.
 
-As an example, consider the following::
+As an example, consider the following:
+
+.. code-block:: bitbake
 
    do_foo() {
        bbplain first
@@ -1286,7 +1424,9 @@ BitBake-Style Python Functions
 These functions are written in Python and executed by BitBake or other
 Python functions using ``bb.build.exec_func()``.
 
-An example BitBake function is::
+An example BitBake function is:
+
+.. code-block:: bitbake
 
    python some_python_function () {
        d.setVar("TEXT", "Hello World")
@@ -1309,7 +1449,9 @@ import these modules. Also in these types of functions, the datastore
 Similar to shell functions, you can also apply overrides and
 override-style operators to BitBake-style Python functions.
 
-As an example, consider the following::
+As an example, consider the following:
+
+.. code-block:: bitbake
 
    python do_foo:prepend() {
        bb.plain("first")
@@ -1338,7 +1480,9 @@ Python Functions
 These functions are written in Python and are executed by other Python
 code. Examples of Python functions are utility functions that you intend
 to call from in-line Python or from within other Python functions. Here
-is an example::
+is an example:
+
+.. code-block:: bitbake
 
    def get_depends(d):
        if d.getVar('SOMECONDITION'):
@@ -1428,7 +1572,9 @@ Sometimes it is useful to set variables or perform other operations
 programmatically during parsing. To do this, you can define special
 Python functions, called anonymous Python functions, that run at the end
 of parsing. For example, the following conditionally sets a variable
-based on the value of another variable::
+based on the value of another variable:
+
+.. code-block:: bitbake
 
    python () {
        if d.getVar('SOMEVAR') == 'value':
@@ -1441,7 +1587,9 @@ the name "__anonymous", rather than no name.
 Anonymous Python functions always run at the end of parsing, regardless
 of where they are defined. If a recipe contains many anonymous
 functions, they run in the same order as they are defined within the
-recipe. As an example, consider the following snippet::
+recipe. As an example, consider the following snippet:
+
+.. code-block:: bitbake
 
    python () {
        d.setVar('FOO', 'foo 2')
@@ -1456,7 +1604,9 @@ recipe. As an example, consider the following snippet::
    BAR = "bar 1"
 
 The previous example is conceptually
-equivalent to the following snippet::
+equivalent to the following snippet:
+
+.. code-block:: bitbake
 
    FOO = "foo 1"
    BAR = "bar 1"
@@ -1470,7 +1620,9 @@ available to tasks, which always run after parsing.
 
 Overrides and override-style operators such as "``:append``" are applied
 before anonymous functions run. In the following example, ``FOO`` ends
-up with the value "foo from anonymous"::
+up with the value "foo from anonymous":
+
+.. code-block:: bitbake
 
    FOO = "foo"
    FOO:append = " from outside"
@@ -1518,13 +1670,17 @@ To make use of this technique, you need the following things in place:
       bar_do_foo
 
 -  The class needs to contain the ``EXPORT_FUNCTIONS`` statement as
-   follows::
+   follows:
+
+   .. code-block:: bitbake
 
       EXPORT_FUNCTIONS functionname
 
    For example, continuing with
    the same example, the statement in the ``bar.bbclass`` would be as
-   follows::
+   follows:
+
+   .. code-block:: bitbake
 
       EXPORT_FUNCTIONS do_foo
 
@@ -1567,7 +1723,9 @@ Tasks are either :ref:`shell functions <bitbake-user-manual/bitbake-user-manual-
 that have been promoted to tasks by using the ``addtask`` command. The
 ``addtask`` command can also optionally describe dependencies between
 the task and other tasks. Here is an example that shows how to define a
-task and declare some dependencies::
+task and declare some dependencies:
+
+.. code-block:: bitbake
 
    python do_printdate () {
        import datetime
@@ -1598,7 +1756,9 @@ Additionally, the ``do_printdate`` task becomes dependent upon the
    rerun for experimentation purposes, you can make BitBake always
    consider the task "out-of-date" by using the
    :ref:`[nostamp] <bitbake-user-manual/bitbake-user-manual-metadata:Variable Flags>`
-   variable flag, as follows::
+   variable flag, as follows:
+
+   .. code-block:: bitbake
 
       do_printdate[nostamp] = "1"
 
@@ -1612,7 +1772,9 @@ Additionally, the ``do_printdate`` task becomes dependent upon the
    name.
 
 You might wonder about the practical effects of using ``addtask``
-without specifying any dependencies as is done in the following example::
+without specifying any dependencies as is done in the following example:
+
+.. code-block:: bitbake
 
    addtask printdate
 
@@ -1634,7 +1796,9 @@ on variable flags you can use with tasks.
 
    While it's infrequent, it's possible to define multiple tasks as
    dependencies when calling ``addtask``. For example, here's a snippet
-   from the OpenEmbedded class file ``package_tar.bbclass``::
+   from the OpenEmbedded class file ``package_tar.bbclass``:
+
+   .. code-block:: bitbake
 
      addtask package_write_tar before do_build after do_packagedata do_package
 
@@ -1646,7 +1810,9 @@ Deleting a Task
 
 As well as being able to add tasks, you can delete them. Simply use the
 ``deltask`` command to delete a task. For example, to delete the example
-task used in the previous sections, you would use::
+task used in the previous sections, you would use:
+
+.. code-block:: bitbake
 
    deltask printdate
 
@@ -1662,7 +1828,9 @@ to run before ``do_a``.
 
 If you want dependencies such as these to remain intact, use the
 ``[noexec]`` varflag to disable the task instead of using the
-``deltask`` command to delete it::
+``deltask`` command to delete it:
+
+.. code-block:: bitbake
 
    do_b[noexec] = "1"
 
@@ -1774,7 +1942,9 @@ functionality of the task:
 
    The value set to the list is a file-boolean pair where the first
    value is the file name and the second is whether or not it
-   physically exists on the filesystem. ::
+   physically exists on the filesystem.
+
+   .. code-block:: bitbake
 
       do_configure[file-checksums] += "${MY_DIRPATH}/my-file.txt:True"
 
@@ -1898,7 +2068,9 @@ intent is to make it easy to do things like email notification on build
 failures.
 
 Following is an example event handler that prints the name of the event
-and the content of the :term:`FILE` variable::
+and the content of the :term:`FILE` variable:
+
+.. code-block:: bitbake
 
    addhandler myclass_eventhandler
    python myclass_eventhandler() {
@@ -2017,7 +2189,9 @@ BitBake supports multiple incarnations of a recipe file via the
 The :term:`BBCLASSEXTEND` variable is a space separated list of classes used
 to "extend" the recipe for each variant. Here is an example that results in a
 second incarnation of the current recipe being available. This second
-incarnation will have the "native" class inherited. ::
+incarnation will have the "native" class inherited.
+
+.. code-block:: bitbake
 
       BBCLASSEXTEND = "native"
 
@@ -2057,7 +2231,9 @@ Dependencies Internal to the ``.bb`` File
 BitBake uses the ``addtask`` directive to manage dependencies that are
 internal to a given recipe file. You can use the ``addtask`` directive
 to indicate when a task is dependent on other tasks or when other tasks
-depend on that recipe. Here is an example::
+depend on that recipe. Here is an example:
+
+.. code-block:: bitbake
 
    addtask printdate after do_fetch before do_build
 
@@ -2095,7 +2271,9 @@ Build Dependencies
 BitBake uses the :term:`DEPENDS` variable to manage
 build time dependencies. The ``[deptask]`` varflag for tasks signifies
 the task of each item listed in :term:`DEPENDS` that must complete before
-that task can be executed. Here is an example::
+that task can be executed. Here is an example:
+
+.. code-block:: bitbake
 
    do_configure[deptask] = "do_populate_sysroot"
 
@@ -2113,7 +2291,9 @@ The :term:`PACKAGES` variable lists runtime packages. Each of those packages
 can have :term:`RDEPENDS` and :term:`RRECOMMENDS` runtime dependencies. The
 ``[rdeptask]`` flag for tasks is used to signify the task of each item
 runtime dependency which must have completed before that task can be
-executed. ::
+executed.
+
+.. code-block:: bitbake
 
    do_package_qa[rdeptask] = "do_packagedata"
 
@@ -2137,7 +2317,9 @@ dependencies are discovered and added.
 
 The ``[recrdeptask]`` flag is most commonly used in high-level recipes
 that need to wait for some task to finish "globally". For example,
-``image.bbclass`` has the following::
+``image.bbclass`` has the following:
+
+.. code-block:: bitbake
 
    do_rootfs[recrdeptask] += "do_packagedata"
 
@@ -2146,7 +2328,9 @@ the current recipe and all recipes reachable (by way of dependencies)
 from the image recipe must run before the ``do_rootfs`` task can run.
 
 BitBake allows a task to recursively depend on itself by
-referencing itself in the task list::
+referencing itself in the task list:
+
+.. code-block:: bitbake
 
    do_a[recrdeptask] = "do_a do_b"
 
@@ -2163,7 +2347,9 @@ Inter-Task Dependencies
 BitBake uses the ``[depends]`` flag in a more generic form to manage
 inter-task dependencies. This more generic form allows for
 inter-dependency checks for specific tasks rather than checks for the
-data in :term:`DEPENDS`. Here is an example::
+data in :term:`DEPENDS`. Here is an example:
+
+.. code-block:: bitbake
 
    do_patch[depends] = "quilt-native:do_populate_sysroot"
 

