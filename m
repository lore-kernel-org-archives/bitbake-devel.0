Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAF2CD4F54
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 17:01:43 +0000 (UTC)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63.1780074094784805189
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2026 10:01:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nW0CA9CT;
 spf=pass (domain: gmail.com, ip: 74.125.82.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13643f6d1a9so5040232c88.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 10:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780074094; cv=none;
        d=google.com; s=arc-20240605;
        b=fjoZtZju6kSelSihZhKezG9taBv/Rdt1UldCnuai8jHJD5hf0SGTx0baXC5Lk0B4Ts
         /+NnXWNcziuZDfJ+WpCne5foXu7d4JaSQ+pIwacGeG7K18J1DpB4Q/o99ufP5dPslLR/
         5dj+2OnIedEdba3JoH5HZaaahk5KI3xXqX/t06l9oUqOCIytcTTw6K5gTJRTCh8mAHcn
         5X8DScPLCf8PbfRGD75AEBmuz4SgpOtOl50UiHO5QtHDxOyIN0SB/MVoK9RnwfHEoW5n
         nEFQ80m3ldX93dS6UP0IMjvsQ0KLwnJghKRvYmQI1ueMEvMCzrbnAC+O9dyr0YwhXDo3
         9PaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jo9vdvnpP/dC2LtU7WORLK5XbIFaK1m3SK7VhetHHiU=;
        fh=GWExUfJR88oeVCRfRxKHLPc/xMpLE0KqWIH3LUJXQUs=;
        b=OSrR8SRoRq5WMD/z1d0JSQ8c1Ws7weA7uMCC8y6dqI/bRuzn5v1SvNhO0A1DvT9fo9
         y0tT6qpg3uuG6mkHhHYqb3ixrDOXr5ZCII4pkHhu83AzV6RBc2qrLCWurFvRg5h3q0Sv
         fKLFK6J9a9KeyeBBIxpTAhlhcwphu4APuuyiFhZUCnvbmUVQizkT/GQnrXhhaWaOiW5n
         swFsyQCpE1DGOeDH47folUeLC9gS76ZcfIq49QZz5Y2GSWo0GhT2kmz3XSCZU7AaJLFE
         QMKZcScKc8RUrOg1kHQ4rcFj2oMvNbZwNxuip+VlYK7+DcOfQX+pyzmRDIjSecczlJKx
         wt5g==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780074094; x=1780678894; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo9vdvnpP/dC2LtU7WORLK5XbIFaK1m3SK7VhetHHiU=;
        b=nW0CA9CTwf/tWcxoPCD3wLyPBvMXixYk0vaupqeQ+66FpKtFvrWDuMgWcNb+4AI9tE
         Iy2zf46PzExrbocUYQs/RsU7X20hYXJPqcp95yKANbeVIfJQRoXVRA2YI6Yz85czaglj
         3vnTj8kt1av9z0DxHtwlJElAlagLbPSNGWBiJ7RVprKud08NKBJpSAco8rrrTlZKYSxi
         pjlw07gqQIqfikGi8ILm6IapfGBWmn/oxDg+P3paS7Yng/AhVbOxRsI2mhg3Usj3Y5Ea
         pBAP6FR5UQb1r2YkUAsj9qHn82zBxJnr8wEYQ7CIELySpBC9ct6Y+faeS2PZRyN/w1cc
         Rxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780074094; x=1780678894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jo9vdvnpP/dC2LtU7WORLK5XbIFaK1m3SK7VhetHHiU=;
        b=inV4Uf/VT+2Mdh2xUzYjyybO04f3ZcX53uR+MuB7FgR35ivehTF75GjQEH7M3LzBSN
         hBG8blLv+PJsku0J1jHYU9PC3670sL/A8OxEvsKP2JfqPoGQqBERwmZ3RfnNUpt5hopV
         qcghyfniPvgiIegEmmTkF2upJEVtxYuk1gCQNpqhEJY2g1i7szPcT5nUaGI+T9av1jyZ
         7caSoKYkiv40waElxHF3MZsxnzS0V23X7kYEHzVQF8SIWjyUT8IZVK9BTXJcKhQUQahw
         hyAMwSYr5p8sYaAeWl8P71nqLBy784DemwzAWK7BxrbVY2BrW3tKFXaCyZHeyuZDZBpZ
         jBiw==
X-Gm-Message-State: AOJu0YxwkSdaqz/WFmogLyXHSAJS30N9P9AN5PcDg574FQj9upaNyehf
	YvEw7qUTtTjFkMt6lEapLtGu4heHqPyMpcUsTl2u0oULlLoqicDezq5yyrNkFktb47TbkG5Sf8J
	VdZ3YUghwpn7SIAxrfzusutKKT/jrEMs=
X-Gm-Gg: Acq92OGfGE6igiW58NpuRKo/WUWzhWDyDnG/QIjBzW9RJAB9dyFkFflaxhRAoso0J5y
	NQO8nXCQwGvvvNbOGhZR2GYHQF/AIuTZHIu58QnX0KmUtSB+2c2feyvm9M0C2rLDKGt0KEhh1vc
	DK0DKOaTX5z8VJgnhjOPw3PC09IuBfeCUad3kGWMx4JekpcBG81wILO89e+RSiKvxFbPkuFT35r
	83qqFXGkLkM1x3Zr6rVW7PbH6ys+wikA4WlKxjlg5mfPQF6oXNeSL60BASOp2SGxy/ahn/tehZv
	taumLqYuaWV4EzqJSwjiMqT7jhc7lEPWWp0gf7zrj7ddO6bkq9Ka
X-Received: by 2002:a05:7022:ff48:b0:133:598c:2b1a with SMTP id
 a92af1059eb24-137d426f3famr212829c88.41.1780074093743; Fri, 29 May 2026
 10:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com> <20260529-bb-setup-notes-v1-2-a251ef1c5af4@toradex.com>
In-Reply-To: <20260529-bb-setup-notes-v1-2-a251ef1c5af4@toradex.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 29 May 2026 19:01:21 +0200
X-Gm-Features: AVHnY4ILiECcTnvB-HaNUYuUJZFCgqQNn3ALsabik8uW5nduK3ob7MHSFPt5QB0
Message-ID: <CANNYZj-4zkd76D8YvMvfYTZQM7UgnrhPfrtVQ1cDSGasTZQzAQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: write notes for
 generated build configs
To: ernestvanhoecke@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 17:01:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19571

Thanks, this lgtm too.

Alex

On Fri, 29 May 2026 at 17:00, Ernest Van Hoecke via
lists.openembedded.org
<ernestvanhoecke=gmail.com@lists.openembedded.org> wrote:
>
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> For bb-layers configurations, bitbake-setup currently writes an empty
> "conf-notes.txt". Configurations using "oe-template" get this file from
> the template.
>
> Add an optional field called "notes" to configurations that populates
> this field when "bb-layers" is used instead of "oe-template".
>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
>  bin/bitbake-setup                                                 | 3 ++-
>  doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 5 +++++
>  lib/bb/tests/setup.py                                             | 4 ++++
>  setup-schema/bitbake-setup.schema.json                            | 4 ++++
>  4 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 220540f7f9ca..e22e5b77bde1 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -301,7 +301,8 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
>              f.write(bitbake_config["description"] + "\n")
>
>          with open(os.path.join(build_conf_dir, "conf-notes.txt"), 'w') as f:
> -            f.write("")
> +            notes = bitbake_config.get("notes")
> +            f.write(notes + "\n" if notes else "")
>
>      def _make_init_build_env(builddir, oeinitbuildenvdir):
>          builddir = os.path.realpath(builddir)
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index 1252f22c823a..e99cf7b3415d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -1057,6 +1057,11 @@ They contain the following sections:
>        snippet. This is what is prompted during the
>        :ref:`ref-bbsetup-command-init` command execution.
>
> +   -  ``notes`` (*optional*): additional information written to
> +      ``build/conf/conf-notes.txt`` when ``bitbake-setup`` generates the build
> +      configuration from ``bb-layers``. For ``oe-template`` configurations,
> +      this file is provided by the template.
> +
>     -  ``configurations``: Configurations can recursively contain as many nested
>        configurations as needed. This will create more choices when running the
>        :ref:`ref-bbsetup-command-init` command.
> diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
> index 638d56d3bb32..ffe390db1bda 100644
> --- a/lib/bb/tests/setup.py
> +++ b/lib/bb/tests/setup.py
> @@ -136,6 +136,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>              {
>                  "name": "gadget-notemplate",
>                  "description": "Gadget notemplate configuration",
> +                "notes": "Gadget notemplate notes",
>                  "bb-layers": ["layerA","layerB/meta-layer"],
>                  "oe-fragments": ["test-fragment-1"]
>              },
> @@ -249,6 +250,9 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>          else:
>              with open(os.path.join(bb_conf_path, 'conf-summary.txt')) as f:
>                  self.assertIn(bitbake_config["description"], f.read())
> +            with open(os.path.join(bb_conf_path, 'conf-notes.txt')) as f:
> +                expected_notes = bitbake_config.get("notes")
> +                self.assertEqual(f.read(), expected_notes + "\n" if expected_notes else "")
>              with open(os.path.join(bb_conf_path, 'bblayers.conf')) as f:
>                  bblayers = f.read()
>                  for l in bitbake_config["bb-layers"]:
> diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
> index be8772db1b2d..6a39e66a0ae4 100644
> --- a/setup-schema/bitbake-setup.schema.json
> +++ b/setup-schema/bitbake-setup.schema.json
> @@ -41,6 +41,10 @@
>                                  "type": "string",
>                                  "description": "Human-readable description of the configuration"
>                              },
> +                            "notes": {
> +                                "type": "string",
> +                                "description": "Extra notes that populate conf-notes.txt when bb-layers is used"
> +                            },
>                              "bb-layers": {
>                                  "type": "array",
>                                  "description": "List of BitBake layer paths to include, relative to the layers download directory",
>
> --
> 2.43.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19565): https://lists.openembedded.org/g/bitbake-devel/message/19565
> Mute This Topic: https://lists.openembedded.org/mt/119548246/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

