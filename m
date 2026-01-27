Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68B4D2FEF0
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 21:53:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1279.1769550800078131289
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 13:53:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=auACkwtz;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.168.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RHDmdw1980775
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:19 GMT
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by1jx0ute-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b70d8095daso5966240eec.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 13:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769550798; x=1770155598; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESse4nNoHkFl7Nd8RaCGODmg93SudfdI2uaP9m81xxE=;
        b=auACkwtzEWGnAq9hGx536p53l5EVIzXBG7SmyWMKrQlcpgu+3TbyzM76E/nIKCZ1uO
         QroAHpXEBg5JgfPA7GHA+YA6lohjiTJ6Nyf4snny9cuHhMCU7N48d3kNYrsLZSgX9p9d
         02sBIMH+6LvyF9ViXU6V8a82DKuwyD3j166Dy7l2cYRGZ9ARcXuGF75A+l+lldGPyAkN
         qSth2TQx8S3d3onr/aFnm3rAhWKh28T7duYiubPymNGZoEsy5vccpLtUluDT9oSobZTn
         gxTKKaGX1o7OBIeFUOS9DK6wnD7ixGJHHLGpWW0nfcx5iNG/MgV9ajVncAjy53DUyKXa
         UTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769550798; x=1770155598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ESse4nNoHkFl7Nd8RaCGODmg93SudfdI2uaP9m81xxE=;
        b=WCa+Bjm3Murh0OsOUpKOgyaLA+vBadag+NK63IGLeM4AU4uVW14/x5QBECygjWEY97
         mz/cYMqSx9TpuX0fFxvQzOqBaDqX/XnA9vYFJMu+Rz1JxDIolBo940cSYAnIbO80T1if
         A8m5gLMca1gM4h36+5GbeTgYm1hGTv5lUDXc+wgWU92DfGeX+x92iAeDS7cC0YQ187c7
         k4Cf82XvehjFE5MJJyjoV2IyEwefZDTLkpBwcwNOS0gyhRVuY4OY/J3/uM8f5HUf0F2e
         epV0Tpm/1jf/v4qZAPG7jZE75a/UVw4ZJXPQZ9tlifNu2hC6R9Gmbr/ZArp2QnlclWAa
         mIqQ==
X-Gm-Message-State: AOJu0Yx9eCuLJdTpGzQGvCaRjNC4Yz1KzZ/sPazcGjeWpxdaXvjp9NAl
	Epdlx2xRzMnGSPGW43EorY30KJ5uFNoP9t8N0b+1lZG623TYeEsc5UNK2oUU1lOTxnb7HV74aol
	JhQAllMcFt8DVBjGGome+64boz+3hp+p10RF+fQYs67P0vpJclvlqVd0ehA3kpSRZdE4Nquw3+Y
	uGRdSJeJdx
X-Gm-Gg: AZuq6aJqRQybmbjSn21AfGn/fAuN16DHNW+SfcSqeabw58zNYs70rsaja0o73Z+1Dfr
	4i20/4kgszplfJbDbHgLbp+JoyUklTiKv+PzbP3dP5a2793S9leqBDI7bJFrho4huPbtEzxjYsj
	hT4Y2qauykcwWqtH20cVz5WvjH3JWyCWpfghD0PJr9+Bde4XE6zm5dZvVrR31kodYp4XunxD8FJ
	9AFf2gpzmGShvOM/qsq5TJj09tC0I4R1RPm7nT/tm53XFuUZ5HU0A5E52aM0TzdEcs39KLEo/Mv
	kFCe0hzngZ9d3/0b3diCCPh+WRiA0vXfGYJCM2ej4rH65a4/e5gw4M95k+oFd0UgBGFDut5Fn3d
	W9gubjRYDzqEL9CCunWrRBP9Bc1JYOBuLZU5uaZTHKTeZKbNYZspV0vsuUgEFbZlG/KzAIbePhF
	W3Mg==
X-Received: by 2002:a05:7022:fa3:b0:123:35cb:96e3 with SMTP id a92af1059eb24-124a00e4d53mr1984603c88.46.1769550798180;
        Tue, 27 Jan 2026 13:53:18 -0800 (PST)
X-Received: by 2002:a05:7022:fa3:b0:123:35cb:96e3 with SMTP id a92af1059eb24-124a00e4d53mr1984581c88.46.1769550797492;
        Tue, 27 Jan 2026 13:53:17 -0800 (PST)
Received: from lola.lan ([187.183.40.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9cdcbcfsm31627c88.0.2026.01.27.13.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 13:53:17 -0800 (PST)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
        Daiane Angolini <daiane.angolini@foundries.io>
Subject: [docs][PATCH v2 1/4] doc: change some terminology around bitbake-setup
Date: Tue, 27 Jan 2026 18:53:00 -0300
Message-Id: <20260127215303.512936-2-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127215303.512936-1-daiane.angolini@foundries.io>
References: <20260127215303.512936-1-daiane.angolini@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4gdq82nwOzdDfFWV6pgYlJ5GkSuzg35e
X-Authority-Analysis: v=2.4 cv=duPWylg4 c=1 sm=1 tr=0 ts=697933cf cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=PIITv4rVe324bgT4salBLw==:17
 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Q4-j1AaZAAAA:8 a=A1X0JdhQAAAA:8 a=YEfPZHoM8sb2t3cV5ooA:9
 a=PxkB5W3o20Ba91AHUih5:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE3OCBTYWx0ZWRfX1w8VNtg7psWR
 XONzb/D6byNBkunfGS0VA2VswVWQKReLTq0SQ44UiyycybQP0qmS898+Mf1r6HwLyYfoRRiXYTJ
 eH8f77zBYXAz3m/vVPmtORlcHxotBLSs4L4vQO0ZVcTfoA5EDfJFkPPm84IFLrp91efnb7+gcgB
 dvRk6k0zuiJnoESNds9dHyjvcjHUl/IE4k2sHiF25EtT+POXZaer1XYdKCzD8sE/9dfWdh98sus
 9d25Tc9kRnTQiLIRHGCP+VjiZ2hqTQqCIPR2dDqGC0GtUegYcJurnMy79dcpLhTzg8Y1X5H+iJk
 XlNRDet7UdmSWWv3QG11zbtNN9t+SeWfgoQR6NLucjj/WQnF472y5j4BdlqhvSRuWWTmTJv0OJk
 oM/EEvzZDSD8YBQU4S96i/8wsrfHIhYgUhvvsW9M8k1s+4t/GEn6D2Zl8r7aVQQmybwqdyA9vor
 kC7bT6EIuFyDaNISvIg==
X-Proofpoint-GUID: 4gdq82nwOzdDfFWV6pgYlJ5GkSuzg35e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270178
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18906

Change some terms to use more specific wording:

  Generic Configuration  -> Configuration Template
  Specific Configuration -> Configuration Instance

Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
---
 .../bitbake-user-manual-environment-setup.rst | 86 +++++++++----------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 3b6a73fd8..76f5c41e3 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -41,8 +41,8 @@ Quick Start
       $ ./bitbake/bin/bitbake-setup init
 
    This command will ask you to choose which configurations to use available as
-   part of the default BitBake :term:`generic configurations <generic
-   Configuration>`.
+   part of the default BitBake :term:`Configuration Templates <Configuration
+   Template>`.
 
    .. note::
 
@@ -73,8 +73,8 @@ Quick Start
 
       The name of the directory will vary depending on the choices.
 
-   -  ``config/``: holds the :term:`Specific Configuration`, which embeds the
-      :term:`Generic Configuration` (first choice of the :ref:`ref-bbsetup-command-init` command)
+   -  ``config/``: holds the :term:`Configuration Instance`, which embeds the
+      :term:`Configuration Template` (first choice of the :ref:`ref-bbsetup-command-init` command)
       and the choices made during the initialization.
 
    -  ``build/``: the :term:`BitBake Build` directory, where BitBake stores
@@ -145,12 +145,12 @@ The "Top Directory" and "Setup" directories are defined as follows:
    :term:`Setup`
       A Setup is the result of the :ref:`ref-bbsetup-command-init`
       command, which creates a :term:`Setup` directory. It is constructed from a
-      :term:`Generic Configuration` and choices made during the ``init`` command.
+      :term:`Configuration Template` and choices made during the ``init`` command.
 
       It contains at least:
 
       -  A :term:`BitBake Build` (``build/`` directory).
-      -  A :term:`Specific Configuration` (``config/`` directory).
+      -  A :term:`Configuration Instance` (``config/`` directory).
       -  Sources such as :ref:`layers
          <bitbake-user-manual/bitbake-user-manual-intro:Layers>` or other
          repositories managed by ``bitbake-setup`` (``layers/`` directory).
@@ -173,8 +173,8 @@ The following components are involved to create the content of these directories
       Build` constitute the :ref:`BitBake configuration
       <bitbake-user-manual/bitbake-user-manual-intro:Configuration Files>`.
 
-   :term:`Generic Configuration`
-      A Generic Configuration is a file in JSON format containing a template to
+   :term:`Configuration Template`
+      A Configuration Template is a file in JSON format containing a template to
       create a :term:`Setup`. These files are used during the :ref:`ref-bbsetup-command-init`
       command as a starting point to configure the :term:`Setup`. When the
       command runs, the user may be prompted with choices to further specify the
@@ -183,42 +183,42 @@ The following components are involved to create the content of these directories
       It is also possible to specify the choices on the command line for a
       completely non-interactive initialization.
 
-      :term:`Generic Configuration` files are stored in :term:`registries
+      :term:`Configuration Template` files are stored in :term:`registries
       <Registry>`, and can be listed with the :ref:`ref-bbsetup-command-list`
       command.
 
-      :term:`Generic Configuration` files must end with the ``.conf.json``
+      :term:`Configuration Template` files must end with the ``.conf.json``
       suffix for ``bitbake-setup`` to locate them.
 
       .. note::
 
-         The default :term:`Generic Configurations <Generic Configuration>` are
+         The default :term:`Configuration Templates <Configuration Template>` are
          located in the BitBake repository in a local registry. the
          ``default-registry/`` directory. This can be modified with the
          :ref:`ref-bbsetup-setting-registry` setting.
 
       :ref:`ref-bbsetup-command-status` will tell if a :term:`Setup`
-      is in sync with the :term:`Generic Configuration` it was constructed from
+      is in sync with the :term:`Configuration Template` it was constructed from
       (typically: layer updates).
 
       :ref:`ref-bbsetup-command-update` will bring a :term:`Setup`
-      in sync with its :term:`Generic Configuration`.
+      in sync with its :term:`Configuration Template`.
 
-   :term:`Specific Configuration`
-      The :term:`Specific Configuration` is stored in the ``config/`` directory
-      in a :term:`Setup`. It embeds the :term:`Generic Configuration` and the
+   :term:`Configuration Instance`
+      The :term:`Configuration Instance` is stored in the ``config/`` directory
+      in a :term:`Setup`. It embeds the :term:`Configuration Template` and the
       choices made during the initialization.
 
-      It is also a Git repository, that contains a history of the specific
-      configuration and updates made to it via :ref:`ref-bbsetup-command-update`.
+      It is also a Git repository, that contains a history of the configuration
+      instance and updates made to it via :ref:`ref-bbsetup-command-update`.
 
    :term:`Registry`
-      A configuration registry is a place where one or more :term:`Generic
-      Configurations <Generic Configuration>` are stored.
+      A configuration registry is a place where one or more :term:`Configuration
+      Templates <Configuration Template>` are stored.
 
       The directory structure of the registry can be any: ``bitbake-setup``
       recursively find files ending with ``.conf.json`` and consider it a
-      :term:`Generic Configuration`.
+      :term:`Configuration Template`.
 
       The registry location is configured through the
       :ref:`ref-bbsetup-setting-registry` setting. This location can be the URL to
@@ -279,7 +279,7 @@ The ``bitbake-setup init`` sub-command helps initializing a :term:`Setup`.
 
 This command can be run without any arguments to prompt the user with
 configuration options to choose from. These configuration options are taken from
-the input :term:`Generic Configuration` files in the :term:`registry`.
+the input :term:`Configuration Template` files in the :term:`registry`.
 
 .. note::
 
@@ -288,9 +288,9 @@ the input :term:`Generic Configuration` files in the :term:`registry`.
 
 Otherwise, the first argument to :ref:`ref-bbsetup-command-init` can be:
 
--  A generic configuration ID in the registry.
--  A path to a generic configuration file on a local disk.
--  An HTTP URI to the generic configuration file.
+-  A Configuration Template ID in the registry.
+-  A path to a Configuration Template file on a local disk.
+-  An HTTP URI to the Configuration Template file.
 
 The choices made during the bare ``bitbake-setup init`` command can also be
 passed directly on the command-line, for example::
@@ -331,7 +331,7 @@ In addition, the command can take the following arguments:
 ``bitbake-setup init`` Examples
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
--  This example prompts the user to choose a :term:`Generic Configuration` from
+-  This example prompts the user to choose a :term:`Configuration Template` from
    a custom registry:
 
    .. code-block:: shell
@@ -340,18 +340,18 @@ In addition, the command can take the following arguments:
           --setting default registry 'git://example.com/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main' \
           init
 
--  This example takes a :term:`Generic Configuration` from a remote location
+-  This example takes a :term:`Configuration Template` from a remote location
    (here, one of the default configuration in BitBake):
 
    .. code-block:: shell
 
       $ ./bitbake/bin/bitbake-setup init https://git.openembedded.org/bitbake/plain/default-registry/configurations/oe-nodistro-master.conf.json
 
--  This example initializes a :term:`Setup` with: 
+-  This example initializes a :term:`Setup` with:
 
    -  A custom :ref:`ref-bbsetup-setting-top-dir-prefix` and :ref:`ref-bbsetup-setting-top-dir-name`
    -  A :term:`source override`, and additionally overriding openembedded-core with a locally managed directory.
-   -  A standalone :term:`generic configuration` file.
+   -  A standalone :term:`Configuration Template` file.
    -  Choices passed on the command-line, applied non-interactively.
 
    .. code-block:: shell
@@ -371,8 +371,8 @@ In addition, the command can take the following arguments:
 ``bitbake-setup list``
 ----------------------
 
-The ``bitbake-setup list`` sub-command lists the available :term:`generic
-configurations <generic configuration>` in the current :term:`registry`.
+The ``bitbake-setup list`` sub-command lists the available :term:`Configuration
+Templates <Configuration Template>` in the current :term:`registry`.
 
 In addition, the command can take the following arguments:
 
@@ -388,8 +388,8 @@ In addition, the command can take the following arguments:
 ------------------------
 
 The ``bitbake-setup status`` sub-command shows the status of a
-:term:`Setup`. Any differences between the local copy of the :term:`generic
-configuration` and the upstream one are printed on the console.
+:term:`Setup`. Any differences between the local copy of the :term:`Configuration
+Template` and the upstream one are printed on the console.
 
 If the BitBake environment is sourced and ready to build, the ``bitbake-setup
 status`` command (without any arguments) will show the status of the current
@@ -407,7 +407,7 @@ In addition, the command can take the following arguments:
 ------------------------
 
 The ``bitbake-setup update`` sub-command updates a :term:`Setup` to sync with
-the latest changes from a :term:`generic configuration` it was constructed from.
+the latest changes from the :term:`Configuration Template` it was constructed from.
 The :ref:`ref-bbsetup-command-status` command can be used to show the current
 status of the :term:`Setup` before updating it.
 
@@ -617,16 +617,16 @@ manner.
 
 The :ref:`ref-bbsetup-setting-use-full-setup-dir-name` setting, if set to ``yes``
 will override the suggestions for the :term:`Setup` directory name made by
-``setup-dir-name`` entries in :term:`Generic Configuration` files. This
+``setup-dir-name`` entries in :term:`Configuration Template` files. This
 will make the directory names longer, but fully specific: they will contain
 all selections made during initialization.
 
 .. _ref-bbsetup-section-config-reference:
 
-Generic Configuration Files Reference
-=====================================
+Configuration Template Files Reference
+======================================
 
-:term:`Generic Configurations <Generic Configuration>` are the input files given
+:term:`Configuration Templates <Configuration Template>` are the input files given
 to ``bitbake-setup`` to configure :term:`Setups <Setup>`.
 
 These files are written in the JSON file format and are stored in a
@@ -891,8 +891,8 @@ They contain the following sections:
 
       would expand to ``somebuild-machine_gadget``.
 
-Generic Configuration Examples
-------------------------------
+Configuration Template Examples
+-------------------------------
 
 OpenEmbedded "nodistro" configuration for master branches:
 
@@ -945,10 +945,10 @@ Here is an example file that overrides the branch of the BitBake repository to
    }
 
 -  The ``version`` parameter contains the version of the used configuration, and
-   should match the one of the :term:`Generic Configuration` file in use.
+   should match the one of the :term:`Configuration Template` file in use.
 
 -  The ``sources`` section contains the same options as the ``sources`` option
-   of a :term:`Generic Configuration` file. See the
+   of a :term:`Configuration Template` file. See the
    :ref:`ref-bbsetup-section-config-reference` section for more information.
 
 .. _ref-bbsetup-fixed-revisions:
@@ -956,7 +956,7 @@ Here is an example file that overrides the branch of the BitBake repository to
 Fixed source revisions
 ======================
 
-:term:`Generic Configuration` can set source revisions in ``rev`` to a tag or a branch.
+:term:`Configuration Template` can set source revisions in ``rev`` to a tag or a branch.
 Bitbake-setup will make sure the actual revision will match the tag or branch when performing
 initializations or updates, and will capture the revisions in a :ref:`ref-bbsetup-source-overrides`
 file.
-- 
2.34.1


