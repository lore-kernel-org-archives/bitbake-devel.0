Return-Path: <freesilicon@gmail.com>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
	[209.85.216.195])
	by mail.openembedded.org (Postfix) with ESMTP id D5E1171B9E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Feb 2018 09:41:37 +0000 (UTC)
Received: by mail-qt0-f195.google.com with SMTP id c19so1129412qtm.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Feb 2018 01:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to; 
	bh=5YRX45keQOr2zHoPKB/pE6xVBa0lyAU2Te14RzDmCRI=;
	b=KoQY7BQJ+AYihpr7WMiGebBRbWeay8Qk4kgh5J6x7OVaD7f5dFk0EtEG1Un4DXf1V8
	fblPrctzqDP07KIBJxS6FTaBRBdlnYnF0gAvVjjcz0m0Rs7yF1LaCu38sJ3T5ymBFFGc
	MlIhwcPKCdnYJP60YUAiGam6a0jzgNnpfP/blUVuRWKTOf0Qq8TTlkhiJW4Doijc1vGQ
	vDWfqTyTT9j23ZRhlg2lZS0LVDToTFutZUTlND343eQtcOiuLjN5eVlY331xDVT7Iq+s
	ibA0fAVP4tvSrTveUfp5nJmUwTvrRCTZys8veh/k1+CiYmYKtLyOHdaJLIZpa5cyrAea
	pJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to;
	bh=5YRX45keQOr2zHoPKB/pE6xVBa0lyAU2Te14RzDmCRI=;
	b=eo4hwoH8hL2fKcZZMdK1lY9FjkdG7XrI6XbIfN8joCMkBiI9GFYdYPCgghTxrHnD/m
	7S2QwkSPa3Hkq6oVD0BZis2dir7P7SiznMjnu9Rb2uLhaaLof36QJvygeRMsoFA3VBVj
	V899um5Hr2nKCGS7uwyqh7WaErFCZdXb+yX1e/kAER8P8auadnrLQTLwElOBYbJFH5IC
	P7U0SYhoYfYlnn0FzghTJ8yI0uy74h9PySFxcDlruSJSWv9TXVDu7FwDe1CaWO0Konjp
	36XEyG4tDXa52jq5AX8XM91oA4vARok+r5+9pdWRVA/MxTXzCYQA+dWjF1o6L6eRQIAQ
	7O2Q==
X-Gm-Message-State: APf1xPB5CU3XOGuUp+vOeAIWEiUQNOvk5GwO/k5OzED6mhoXeag7qxxU
	3XG3SANjxmEMpfj9HdeS8GyHXKS6GZiLcp+Ehl7cRzUM
X-Google-Smtp-Source: AH8x2256oAcFDtj/06D328fI0MnVGYVl78Kw+d2XPG4y+Qnx3rioPkSmSg3/95JoGBFxnXKJgcLuAfHUTNIcNsZ06ro=
X-Received: by 10.200.49.28 with SMTP id g28mr4139472qtb.279.1519206098511;
	Wed, 21 Feb 2018 01:41:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.145.66 with HTTP; Wed, 21 Feb 2018 01:41:37 -0800 (PST)
In-Reply-To: <20171113152404.21785-1-freesilicon@gmail.com>
References: <20171113151617.20905-1-freesilicon@gmail.com>
	<20171113152404.21785-1-freesilicon@gmail.com>
From: David Vincent <freesilicon@gmail.com>
Date: Wed, 21 Feb 2018 10:41:37 +0100
Message-ID: <CAKRNOGwa+2mpVKb3n1pYEoR-Gc7LrC6ZC=+3XEAzD_r84H3cUw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v3 0/2] fetch/git: fix per-branch unpacking
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
X-List-Received-Date: Wed, 21 Feb 2018 09:41:38 -0000
Content-Type: text/plain; charset="UTF-8"

2017-11-13 16:24 GMT+01:00 David Vincent <freesilicon@gmail.com>:
> Create branches for each user-supplied name when running checkout and
> set start point of branch to the resolved revision.
> Also, update documentation to better describe this functionality.
>
> Changes in v2:
>   - clarify commit message
>   - update documentation
>
> Changes in v3:
>   - rebase on current master
>
> David Vincent (2):
>   fetch/git: fix per-branch unpacking
>   bitbake-user-manual: update git fetcher
>
>  .../bitbake-user-manual-fetching.xml               | 34 ++++++++++++++++++++--
>  lib/bb/fetch2/git.py                               | 12 ++++----
>  lib/bb/tests/fetch.py                              | 28 ++++++++++++++++++
>  3 files changed, 67 insertions(+), 7 deletions(-)
>
> --
> 2.13.6
>

Ping anyone ?

Is there anything about this patch that makes it unacceptable for inclusion ?
Sorry to insist but this patch is really needed when using feature branches in
a Yocto-like Linux kernel. Without it, it is not possible to merge the correct
version of the feature branch (always the tip is merged without checking the
provided SRCREV).

Please, make any remarks to improve this series.

Best regards,
David

