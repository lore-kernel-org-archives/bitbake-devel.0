Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0ABD19520
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 22:28:20 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33754.1769466489791008383
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jan 2026 14:28:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=XTg/Qusj;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.180.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QLW4lv4101101
	for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:08 GMT
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxg93g3vw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:08 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b6f0b345e3so23873012eec.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 14:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769466487; x=1770071287; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mGMuoCKxg+v7CS/vJcrr+4TXPMAHV7TZ3bw9h2XlM2Y=;
        b=XTg/Qusj9wMtrymUTHMJzNnKIUpjOzsrvLwGJh9FMFeJkgHSIjAdu2YLBjzqXiRdUt
         CvublfTeEOygH5fso8IbQgiioLNumjpt+fNSQXIjFGkfh6xDZWSCXkWewXD0REVlDpbF
         U7OCh4BSctLpRA/kNLNIYJcKGgsVgKdcTCU5CqS9pMw5Eo7ZiBeVFsuZNdD4UpTj6u91
         QKPyQbZLTcOBmlls9mgxpF4lmEqA9NHcj7L0Of7YfPIvMS1Hr7Jc04q3RKwPn7th3JqZ
         APdJ9PRbZY9EoKlsy9aXgM668RE5WXTDI+IAJn1T6hpRq7bWxS1nhGJymJKmPgsvb+e+
         5qRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769466487; x=1770071287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGMuoCKxg+v7CS/vJcrr+4TXPMAHV7TZ3bw9h2XlM2Y=;
        b=pKJnrdoej2b5E0h3hz3iZqwBrxgdqCMD1V5dddlnotVN3Q8/gCKPECS/+YkA++KAzu
         cN8DjTas376bBfs+9yicXgFT8Paf9QzVxe6JjVhoyMB8GfSfin2hMtuxI1PXYRnCqe3D
         f+/6c0e1R0+L/3BL7CAHbwaBB3yiFukStHJk8F7ndRYmYsPDKKOu0sTDmJc7NZFm0kB8
         GjSa4EgFpaeyfowjSzf4HgkJACgUzKI+/IXxqHxl6H1HSD5j9AFFaBrpv4VE2ljuBK1D
         W0f6Gxl9WD7kkecvDh4vS5uLOGl2t1gM+nEhNRYB5gq1UX3QIsCbY7htx1gauBDg9v3j
         lPvw==
X-Gm-Message-State: AOJu0Yz+JFnrOgD18WrRcGndJkGi1Rawr/PAVVC8nccKlQSVBX58dxJS
	QMuvd4S4Zg4mQPKx5s5NlBfJxQ21wI8/wT7dl8282udKm25QwP2pciOyK1UamPRLcRpRrHQTjoq
	mYbKCJXF9n6Z5As6nAVvquPZhASHpjhagwdzKeGaKEROT7hyRd7HTxWKHDXyRkqVe56ZTR0QOhr
	xyYY5+VTDM
X-Gm-Gg: AZuq6aIFqkWxIIdXxq7+fVm7dbbEN3/MmusLBZqS2yZHWMs9gDcGOuWES4YVENRuHyf
	23L9xJwLWHXSbyTUJiRglo14aXxBuxXj7eWEMhWKNguE4qSRZYfbt6fl0okBRhqi5Z8kG1axks4
	TqXfI6IiT552RcXxGycggu+4gt6f+X+5L53tGQvVSmrgdWfO69bwhU0JlmfLKwRwlGJ7mOjwMO9
	4z3cmUMfxTq/i+E+nNo8m5shdKdezuHVDxKggy1HkQFN9oW+kivH0QlRNUU5MUfT1rqPvd475Zd
	ji1Lu3TZ6exmKDqsLfgQ0Ln5h7ycAp1RwnYX+68DjP0qo6/T/13TdwoaqyFgv7D5PDIKs81+Br8
	3PiKuFmzUSk8lcycCHJsZPhY85VLQ2dZIg6PoeaxpsORRlBOqT6Kz7lPDjhSH6fz5OimpWVdtGp
	qeYg==
X-Received: by 2002:a05:7300:80ce:b0:2b7:18eb:a0ba with SMTP id 5a478bee46e88-2b76451543amr3239758eec.36.1769466486899;
        Mon, 26 Jan 2026 14:28:06 -0800 (PST)
X-Received: by 2002:a05:7300:80ce:b0:2b7:18eb:a0ba with SMTP id 5a478bee46e88-2b76451543amr3239736eec.36.1769466486149;
        Mon, 26 Jan 2026 14:28:06 -0800 (PST)
Received: from lola.lan ([187.183.40.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6b6227sm15057543eec.8.2026.01.26.14.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 14:28:05 -0800 (PST)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
        Daiane Angolini <daiane.angolini@foundries.io>
Subject: [docs][PATCH 1/5] doc: change some terminology around bitbake-setup
Date: Mon, 26 Jan 2026 19:27:39 -0300
Message-Id: <20260126222743.411405-1-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE5MiBTYWx0ZWRfX4w6ancoR8vw3
 DbMoYNv4n9sEHEL5b/pYjK1SRrA+irLm7N6g50Ovx1O8nqsKCvW3VM0uKj9CmUrZtn6sW3W/ioS
 kbCLvW7GLNLR1KcSF4Hw8z/y/1xcJIptJnO5ebKW3iLtZE+8JwMunrQSSHzcF6ziZeVVex+LPVW
 B21U/sVWkGyA3puqissm5CL9pV0JJ33CgzIHbdq2OKBx8yJV07WQZLJb3aAoHUdtmKLrkhcHL4T
 Mzoy5jtEhND5djnW5QudZ9bIUPF2lNMlDjkD8xhQoODdrGnH4809kIzZ1tylQzEC6vIctANF6VQ
 SY9BytfoWa/7wY+N0AALUM2oq7xVMJgIn/6OPd9F8rTva8wbrr1r5nGTjwXxvNqRjJfbsZMMVQj
 Tb4DrzfJzQrgXbauJf157wLnSwdbeNf0pvuX8RdmwVj6oA6lFKeWIMDf31g4/rhoNI7sWhIm+Eg
 s0sJJ9N//lXQ0DUnhvg==
X-Authority-Analysis: v=2.4 cv=Uc1ciaSN c=1 sm=1 tr=0 ts=6977ea78 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=PIITv4rVe324bgT4salBLw==:17
 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=A1X0JdhQAAAA:8 a=Y_ynoO3N8lTnrvQkgkkA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: GQGFTI5-ySFGKUf2wX2Ng9I0alJGUm3t
X-Proofpoint-GUID: GQGFTI5-ySFGKUf2wX2Ng9I0alJGUm3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601260192
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18871

Change some terms to use more specific wording:

  Generic Configuration  -> BitBake Setup Template
  Specific Configuration -> BitBake Setup Instance
  nested configurations  -> Variant

Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
---
 .../bitbake-user-manual-environment-setup.rst | 88 +++++++++----------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 3b6a73fd8..824b01ffb 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -41,8 +41,8 @@ Quick Start
       $ ./bitbake/bin/bitbake-setup init
 
    This command will ask you to choose which configurations to use available as
-   part of the default BitBake :term:`generic configurations <generic
-   Configuration>`.
+   part of the default BitBake :term:`BitBake Setup Templates <BitBake Setup
+   Template>`.
 
    .. note::
 
@@ -73,8 +73,8 @@ Quick Start
 
       The name of the directory will vary depending on the choices.
 
-   -  ``config/``: holds the :term:`Specific Configuration`, which embeds the
-      :term:`Generic Configuration` (first choice of the :ref:`ref-bbsetup-command-init` command)
+   -  ``config/``: holds the :term:`BitBake Setup Instance`, which embeds the
+      :term:`BitBake Setup Template` (first choice of the :ref:`ref-bbsetup-command-init` command)
       and the choices made during the initialization.
 
    -  ``build/``: the :term:`BitBake Build` directory, where BitBake stores
@@ -145,12 +145,12 @@ The "Top Directory" and "Setup" directories are defined as follows:
    :term:`Setup`
       A Setup is the result of the :ref:`ref-bbsetup-command-init`
       command, which creates a :term:`Setup` directory. It is constructed from a
-      :term:`Generic Configuration` and choices made during the ``init`` command.
+      :term:`BitBake Setup Template` and choices made during the ``init`` command.
 
       It contains at least:
 
       -  A :term:`BitBake Build` (``build/`` directory).
-      -  A :term:`Specific Configuration` (``config/`` directory).
+      -  A :term:`BitBake Setup Instance` (``config/`` directory).
       -  Sources such as :ref:`layers
          <bitbake-user-manual/bitbake-user-manual-intro:Layers>` or other
          repositories managed by ``bitbake-setup`` (``layers/`` directory).
@@ -173,8 +173,8 @@ The following components are involved to create the content of these directories
       Build` constitute the :ref:`BitBake configuration
       <bitbake-user-manual/bitbake-user-manual-intro:Configuration Files>`.
 
-   :term:`Generic Configuration`
-      A Generic Configuration is a file in JSON format containing a template to
+   :term:`BitBake Setup Template`
+      A BitBake Setup Template is a file in JSON format containing a template to
       create a :term:`Setup`. These files are used during the :ref:`ref-bbsetup-command-init`
       command as a starting point to configure the :term:`Setup`. When the
       command runs, the user may be prompted with choices to further specify the
@@ -183,42 +183,42 @@ The following components are involved to create the content of these directories
       It is also possible to specify the choices on the command line for a
       completely non-interactive initialization.
 
-      :term:`Generic Configuration` files are stored in :term:`registries
+      :term:`BitBake Setup Template` files are stored in :term:`registries
       <Registry>`, and can be listed with the :ref:`ref-bbsetup-command-list`
       command.
 
-      :term:`Generic Configuration` files must end with the ``.conf.json``
+      :term:`BitBake Setup Template` files must end with the ``.conf.json``
       suffix for ``bitbake-setup`` to locate them.
 
       .. note::
 
-         The default :term:`Generic Configurations <Generic Configuration>` are
+         The default :term:`BitBake Setup Templates <BitBake Setup Template>` are
          located in the BitBake repository in a local registry. the
          ``default-registry/`` directory. This can be modified with the
          :ref:`ref-bbsetup-setting-registry` setting.
 
       :ref:`ref-bbsetup-command-status` will tell if a :term:`Setup`
-      is in sync with the :term:`Generic Configuration` it was constructed from
+      is in sync with the :term:`BitBake Setup Template` it was constructed from
       (typically: layer updates).
 
       :ref:`ref-bbsetup-command-update` will bring a :term:`Setup`
-      in sync with its :term:`Generic Configuration`.
+      in sync with its :term:`BitBake Setup Template`.
 
-   :term:`Specific Configuration`
-      The :term:`Specific Configuration` is stored in the ``config/`` directory
-      in a :term:`Setup`. It embeds the :term:`Generic Configuration` and the
+   :term:`BitBake Setup Instance`
+      The :term:`BitBake Setup Instance` is stored in the ``config/`` directory
+      in a :term:`Setup`. It embeds the :term:`BitBake Setup Template` and the
       choices made during the initialization.
 
-      It is also a Git repository, that contains a history of the specific
-      configuration and updates made to it via :ref:`ref-bbsetup-command-update`.
+      It is also a Git repository, that contains a history of the setup instance
+      and updates made to it via :ref:`ref-bbsetup-command-update`.
 
    :term:`Registry`
-      A configuration registry is a place where one or more :term:`Generic
-      Configurations <Generic Configuration>` are stored.
+      A configuration registry is a place where one or more :term:`BitBake
+      Setup Templates <BitBake Setup Template>` are stored.
 
       The directory structure of the registry can be any: ``bitbake-setup``
       recursively find files ending with ``.conf.json`` and consider it a
-      :term:`Generic Configuration`.
+      :term:`BitBake Setup Template`.
 
       The registry location is configured through the
       :ref:`ref-bbsetup-setting-registry` setting. This location can be the URL to
@@ -279,7 +279,7 @@ The ``bitbake-setup init`` sub-command helps initializing a :term:`Setup`.
 
 This command can be run without any arguments to prompt the user with
 configuration options to choose from. These configuration options are taken from
-the input :term:`Generic Configuration` files in the :term:`registry`.
+the input :term:`BitBake Setup Template` files in the :term:`registry`.
 
 .. note::
 
@@ -288,9 +288,9 @@ the input :term:`Generic Configuration` files in the :term:`registry`.
 
 Otherwise, the first argument to :ref:`ref-bbsetup-command-init` can be:
 
--  A generic configuration ID in the registry.
--  A path to a generic configuration file on a local disk.
--  An HTTP URI to the generic configuration file.
+-  A BitBake Setup Template ID in the registry.
+-  A path to a BitBake Setup Template file on a local disk.
+-  An HTTP URI to the BitBake Setup Template file.
 
 The choices made during the bare ``bitbake-setup init`` command can also be
 passed directly on the command-line, for example::
@@ -331,7 +331,7 @@ In addition, the command can take the following arguments:
 ``bitbake-setup init`` Examples
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
--  This example prompts the user to choose a :term:`Generic Configuration` from
+-  This example prompts the user to choose a :term:`BitBake Setup Template` from
    a custom registry:
 
    .. code-block:: shell
@@ -340,7 +340,7 @@ In addition, the command can take the following arguments:
           --setting default registry 'git://example.com/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main' \
           init
 
--  This example takes a :term:`Generic Configuration` from a remote location
+-  This example takes a :term:`BitBake Setup Template` from a remote location
    (here, one of the default configuration in BitBake):
 
    .. code-block:: shell
@@ -351,7 +351,7 @@ In addition, the command can take the following arguments:
 
    -  A custom :ref:`ref-bbsetup-setting-top-dir-prefix` and :ref:`ref-bbsetup-setting-top-dir-name`
    -  A :term:`source override`, and additionally overriding openembedded-core with a locally managed directory.
-   -  A standalone :term:`generic configuration` file.
+   -  A standalone :term:`BitBake Setup Template` file.
    -  Choices passed on the command-line, applied non-interactively.
 
    .. code-block:: shell
@@ -371,8 +371,8 @@ In addition, the command can take the following arguments:
 ``bitbake-setup list``
 ----------------------
 
-The ``bitbake-setup list`` sub-command lists the available :term:`generic
-configurations <generic configuration>` in the current :term:`registry`.
+The ``bitbake-setup list`` sub-command lists the available :term:`BitBake Setup
+Templates <BitBake Setup Template>` in the current :term:`registry`.
 
 In addition, the command can take the following arguments:
 
@@ -388,8 +388,8 @@ In addition, the command can take the following arguments:
 ------------------------
 
 The ``bitbake-setup status`` sub-command shows the status of a
-:term:`Setup`. Any differences between the local copy of the :term:`generic
-configuration` and the upstream one are printed on the console.
+:term:`Setup`. Any differences between the local copy of the :term:`BitBake Setup
+Template` and the upstream one are printed on the console.
 
 If the BitBake environment is sourced and ready to build, the ``bitbake-setup
 status`` command (without any arguments) will show the status of the current
@@ -407,7 +407,7 @@ In addition, the command can take the following arguments:
 ------------------------
 
 The ``bitbake-setup update`` sub-command updates a :term:`Setup` to sync with
-the latest changes from a :term:`generic configuration` it was constructed from.
+the latest changes from the :term:`BitBake Setup Template` it was constructed from.
 The :ref:`ref-bbsetup-command-status` command can be used to show the current
 status of the :term:`Setup` before updating it.
 
@@ -617,16 +617,16 @@ manner.
 
 The :ref:`ref-bbsetup-setting-use-full-setup-dir-name` setting, if set to ``yes``
 will override the suggestions for the :term:`Setup` directory name made by
-``setup-dir-name`` entries in :term:`Generic Configuration` files. This
+``setup-dir-name`` entries in :term:`BitBake Setup Template` files. This
 will make the directory names longer, but fully specific: they will contain
 all selections made during initialization.
 
 .. _ref-bbsetup-section-config-reference:
 
-Generic Configuration Files Reference
-=====================================
+BitBake Setup Template Files Reference
+======================================
 
-:term:`Generic Configurations <Generic Configuration>` are the input files given
+:term:`BitBake Setup Templates <BitBake Setup Template>` are the input files given
 to ``bitbake-setup`` to configure :term:`Setups <Setup>`.
 
 These files are written in the JSON file format and are stored in a
@@ -792,8 +792,8 @@ They contain the following sections:
       snippet. This is what is prompted during the
       :ref:`ref-bbsetup-command-init` command execution.
 
-   -  ``configurations``: Configurations can recursively contain as many nested
-      configurations as needed. This will create more choices when running the
+   -  ``configurations``: Configurations can recursively contain as many
+      variants as needed. This will create more choices when running the
       :ref:`ref-bbsetup-command-init` command.
 
       The purpose of such nesting is to be able to scale the configurations, for
@@ -891,8 +891,8 @@ They contain the following sections:
 
       would expand to ``somebuild-machine_gadget``.
 
-Generic Configuration Examples
-------------------------------
+BitBake Setup Template Examples
+-------------------------------
 
 OpenEmbedded "nodistro" configuration for master branches:
 
@@ -945,10 +945,10 @@ Here is an example file that overrides the branch of the BitBake repository to
    }
 
 -  The ``version`` parameter contains the version of the used configuration, and
-   should match the one of the :term:`Generic Configuration` file in use.
+   should match the one of the :term:`BitBake Setup Template` file in use.
 
 -  The ``sources`` section contains the same options as the ``sources`` option
-   of a :term:`Generic Configuration` file. See the
+   of a :term:`BitBake Setup Template` file. See the
    :ref:`ref-bbsetup-section-config-reference` section for more information.
 
 .. _ref-bbsetup-fixed-revisions:
@@ -956,7 +956,7 @@ Here is an example file that overrides the branch of the BitBake repository to
 Fixed source revisions
 ======================
 
-:term:`Generic Configuration` can set source revisions in ``rev`` to a tag or a branch.
+:term:`BitBake Setup Template` can set source revisions in ``rev`` to a tag or a branch.
 Bitbake-setup will make sure the actual revision will match the tag or branch when performing
 initializations or updates, and will capture the revisions in a :ref:`ref-bbsetup-source-overrides`
 file.
-- 
2.34.1


