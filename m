Return-Path: <nicolac76@yahoo.fr>
Received: from sonic302-19.consmr.mail.ir2.yahoo.com
	(sonic302-19.consmr.mail.ir2.yahoo.com [87.248.110.82])
	by mail.openembedded.org (Postfix) with ESMTP id 35517786D4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jun 2018 06:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.fr; s=s2048;
	t=1529564386; bh=fr4p+q81fDp8mB2T4Th5aOSdcpprDqLya5XemY31ZDA=;
	h=From:To:Cc:Subject:Date:From:Subject;
	b=qkUvBmSEZI9OFX8Vnl/x8VXb2NJZEjAMapu9cPh8fP/MWGRJOMFn4SfXpd38OQynWWXR6DTFGY+8KNTb5x8xBYvlMqGFg1GvhbKLSIVGZVl7oC3jqvWmCMKyfGAAFN3lfrDqJo3kKIR6cwcvbJTr8E0QVd/iujuZN5L4gddYrKMA6Le/0gB87Hlx5vN9GiwaUpWtDi0FQBDISHoaDN+JTdsgCZFaFXhLrqlPVE+N1ia10MhRgfeZTQgbP2KSetkLcVmyrKe9cNubpyxbGLs9p1O+/hDxwQDoSonaBcZJznBX55AvNA+AGtj5/RE3O5dmuSB+JQ2DY/RmgxW7FfZStg==
X-YMail-OSG: fFx9cHsVM1nNv6M8HBfY6_HX_lZn9PG9XeodFDJpX477Q.mLXTZkBdH6ODCywJO
	sEIkpLQxNlpRa.oVBSRAsG_QP9o7VgWA1LDxAwCIbVZfAgRUDEJeYzC4CWNxxa9qlrfp1U3wFWww
	izo0NqnxAbOXuSW_kyi8FbdMWPDy9TJnq.j1SWjYDnCNHG4_aeYSksRbWP9oQHxxlriFMNaS7X61
	R6VP5q9nyasVWILMNwU6CmMaRUXH7RBPRr4kVTYBqw.Xjze2CEuyCv_fjtXVKOLvzGYL0_FcocjP
	Oxo56xFrmkuKuMY_jbbEHtGM7W0yy7EX.aFs6NMlH.bmbBveRR6NdrDZ3IAVDMAn3.p58xFJSnXJ
	_9zn0yZJFfrnK9yN_.1Th9q7W66jcbYK4dWIyh_szJOG8T5npCDgf51LqL42q_bpT6P6Z9D6K6U9
	pEVMCgjZ34Tob79p12yByEYjuBv2I2id8qGslddYAWIw9rdllGLOemN8YDPw8.g0dxC.7MGgYTOO
	CF.6B5.ZmsoUr8qjikGxapWkSNc9uklK0clMJtv9sLCcLZu_U62kEUH69sWozPj0Qjad6IujfmQ2
	zSh4g4ju6bUF5BaiEWeOPc3pyghaekT3_Pv70c0BRNwFrRYwhF5vjAJ5W0kpH_3Hjo7E4_cRFzkt
	Yd4I0u8Xx9XO.ZZ_NdzA69malr9eZUcoQqgIEZJyXFtlowmM3DxmthmnyRF1NNWqZOYuhP7N2R8V
	Na9a8OWZtrTyiqts09Zjith0r35T3fWTwXbPeWlkPr8f.3Ml87X25Cx0Ek0XBmAMEJV4xlPumo.5
	kDipokzGPUODkwq.gqyMmAjcJbAl9TB0EvhPWkaer1CecOUyS2XZp6RWam4cRzg0xGNTyZP9zEGk
	2KsadhrAa0PrEZEd3Iee6zQBYePZe.Rv1arFOCtmotSBmSbisESC1DAFiETztP5NDHb_b6ty_zQ-
	-
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic302.consmr.mail.ir2.yahoo.com with HTTP;
	Thu, 21 Jun 2018 06:59:46 +0000
Received: from 80.245.18.66 (EHLO Achlys.localdomain.com) ([80.245.18.66])
	by smtp404.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
	7547638d565dbf196e7b468ecabeb544; 
	Thu, 21 Jun 2018 06:59:42 +0000 (UTC)
From: Nicolas Cornu <nicolac76@yahoo.fr>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jun 2018 08:59:36 +0200
Message-Id: <20180621065936.31333-1-nicolac76@yahoo.fr>
X-Mailer: git-send-email 2.17.1
Cc: Vivien Henriet <v.henriet@overkiz.com>
Subject: [PATCH] python: fix gcc 8 alignement error.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 21 Jun 2018 06:59:46 -0000

From: Vivien Henriet <v.henriet@overkiz.com>

https://bugs.python.org/issue33374

Change-Id: I2c573447bbe79098317409a8168393f9eb58644c
---
This patch is not here to be merged, but to have review on it.
The problem that this patch try to fix is that if your google-repo got 150 projects, and you want to build each with
a specific recipe, sources vill be copied each time.

 .../fix-generate-posix-vars-crash.patch       | 62 +++++++++++++++++++
 .../python/python-native_2.7.12.bb            |  1 +
 2 files changed, 63 insertions(+)
 create mode 100644 meta/recipes-devtools/python/python-native/fix-generate-posix-vars-crash.patch

diff --git a/meta/recipes-devtools/python/python-native/fix-generate-posix-vars-crash.patch b/meta/recipes-devtools/python/python-native/fix-generate-posix-vars-crash.patch
new file mode 100644
index 0000000000..277d822744
--- /dev/null
+++ b/meta/recipes-devtools/python/python-native/fix-generate-posix-vars-crash.patch
@@ -0,0 +1,62 @@
+From 0b91f8a668201fc58fa732b8acc496caedfdbae0 Mon Sep 17 00:00:00 2001
+From: Florian Weimer <fw@deneb.enyo.de>
+Date: Sun, 29 Apr 2018 12:18:33 -0700
+Subject: [PATCH] Indicate that _PyGC_Head is only 8-byte aligned. (closes
+ bpo-33374)
+
+By spec, the "long double" in _PyGC_Head requires the union to always be 16-byte
+aligned. However, obmalloc only yields 8-byte alignment. Compilers including GCC
+8 are starting to use alignment information to do store-merging. So, the "long
+double" needs to be changed to a simple "double" as was long ago done in Python
+3 by e348c8d154cf6342c79d627ebfe89dfe9de23817. For 2.7, we need to add some
+dummy padding to make sure _PyGC_Head stays the same size.
+---
+ Include/objimpl.h                                       | 17 ++++++++++++++++-
+ .../2018-04-29-12-07-00.bpo-33374.-xegL6.rst            |  3 +++
+ 2 files changed, 19 insertions(+), 1 deletion(-)
+ create mode 100644 Misc/NEWS.d/next/Core and Builtins/2018-04-29-12-07-00.bpo-33374.-xegL6.rst
+
+diff --git a/Include/objimpl.h b/Include/objimpl.h
+index 5f2868332955..cbf6bc3f8763 100644
+--- a/Include/objimpl.h
++++ b/Include/objimpl.h
+@@ -248,6 +248,20 @@ PyAPI_FUNC(PyVarObject *) _PyObject_GC_Resize(PyVarObject *, Py_ssize_t);
+ /* for source compatibility with 2.2 */
+ #define _PyObject_GC_Del PyObject_GC_Del
+ 
++/*
++ * Former over-aligned definition of PyGC_Head, used to compute the size of the
++ * padding for the new version below.
++ */
++union _gc_head;
++union _gc_head_old {
++    struct {
++        union _gc_head_old *gc_next;
++        union _gc_head_old *gc_prev;
++        Py_ssize_t gc_refs;
++    } gc;
++    long double dummy;
++};
++
+ /* GC information is stored BEFORE the object structure. */
+ typedef union _gc_head {
+     struct {
+@@ -255,7 +269,8 @@ typedef union _gc_head {
+         union _gc_head *gc_prev;
+         Py_ssize_t gc_refs;
+     } gc;
+-    long double dummy;  /* force worst-case alignment */
++    double dummy; /* Force at least 8-byte alignment. */
++    char dummy_padding[sizeof(union _gc_head_old)];
+ } PyGC_Head;
+ 
+ extern PyGC_Head *_PyGC_generation0;
+diff --git a/Misc/NEWS.d/next/Core and Builtins/2018-04-29-12-07-00.bpo-33374.-xegL6.rst b/Misc/NEWS.d/next/Core and Builtins/2018-04-29-12-07-00.bpo-33374.-xegL6.rst
+new file mode 100644
+index 000000000000..9ec1a605c8f2
+--- /dev/null
++++ b/Misc/NEWS.d/next/Core and Builtins/2018-04-29-12-07-00.bpo-33374.-xegL6.rst	
+@@ -0,0 +1,3 @@
++Tweak the definition of PyGC_Head, so compilers do not believe it is always
++16-byte aligned on x86. This prevents crashes with more aggressive
++optimizations present in GCC 8.
diff --git a/meta/recipes-devtools/python/python-native_2.7.12.bb b/meta/recipes-devtools/python/python-native_2.7.12.bb
index de83cbd76a..adb23637ae 100644
--- a/meta/recipes-devtools/python/python-native_2.7.12.bb
+++ b/meta/recipes-devtools/python/python-native_2.7.12.bb
@@ -17,6 +17,7 @@ SRC_URI += "\
             file://builddir.patch \
             file://parallel-makeinst-create-bindir.patch \
             file://revert_use_of_sysconfigdata.patch \
+            file://fix-generate-posix-vars-crash.patch \
            "
 
 S = "${WORKDIR}/Python-${PV}"
-- 
2.17.1


