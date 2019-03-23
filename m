Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail.openembedded.org (Postfix) with ESMTP id 9AAB77D00A
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 02:14:51 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id b12so2709628pgk.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Mar 2019 19:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=fTBQXjZpfgIBWfpMIVLm4RiQwu31FwL1xC4/CB7T9SI=;
	b=tXOj09rOdX/F5OtY9H1EAtXUTbgV+yA6gv9SHQv19Nn95teOVq86blY7VNArSyruE5
	XEvzPWNP5aiHy2hc8B7qk6fi8Lgk0/m+kT0TNqhoGMR1I5CAExPb7SwZENf/OsQuTFna
	u++0xO9bSvvwZWMB9KHGU4pICG8nsXU0wWfw3MwT3VJtFpJ2m9N/x5vPw7ZZegPRc1XB
	MR4/tQDsb+9vCabHtttmAx5VkQdJEJTSEur8RhfgSmtVxmrURCgIP2PG8wqd6KnfMBb2
	mB68XybBsoE1J8pmatI2yphGVh3u87foCNw4hp5QnkGakOGljXYJKfghtys8NtXorNnY
	x0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=fTBQXjZpfgIBWfpMIVLm4RiQwu31FwL1xC4/CB7T9SI=;
	b=MOr664J6DRO0FbCIj1plA/N4Sw6tuorvTKXMO5dLk8lWvFHOCI18kj2+3yoKqqb0uK
	ab2gGd0hw+n7NvZpC71s+2axbx1CeO2bdGiNilGjqliXbrBjOpbcLOqgGLmBZxWQwHXJ
	gwcHVUMYuE2sK1bDzfGEu49kc841ujpw/E3oV1gyguOpSJH/CpGAYw+RmSHMKUTm/j1i
	kBUzj8KCGCzX8TN12o0UNUa1nOud/iHcYlMlZlEq/aBP/AHWiqM0Buy3Rrcgsgs00m81
	lX6PMLetV/0K8Ieji/Yd0oBVYl4SGxDwXgwxBvs16uvMaa4jv1FCnWt4iqKiG9yZu4R2
	e/+w==
X-Gm-Message-State: APjAAAWYg+ZkqFkIuhQeh6coUIhMBazfi5IN2hgFkUwJNcTntyhpfJdg
	qi35LF0Mh8k5b5a1NRfJJoG8wPXq
X-Google-Smtp-Source: APXvYqz47WQkheZbBKXbrvCC3t9VVNg4QT4bnCeo7wN9PYHUjmNgDJxBfBXsMgEoYeHdTzL067GL9Q==
X-Received: by 2002:a17:902:1c9:: with SMTP id
	b67mr12466896plb.176.1553307292543; 
	Fri, 22 Mar 2019 19:14:52 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:45a8:35fd:6c1a:9e02?
	([2601:202:4180:c33:45a8:35fd:6c1a:9e02])
	by smtp.gmail.com with ESMTPSA id
	f125sm15486633pfc.91.2019.03.22.19.14.51
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 22 Mar 2019 19:14:52 -0700 (PDT)
To: bitbake-devel@lists.openembedded.org
References: <cover.1553306877.git.akuster808@gmail.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <5afef582-14d5-0665-1b7d-ee432602e1e1@gmail.com>
Date: Fri, 22 Mar 2019 19:14:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1553306877.git.akuster808@gmail.com>
Subject: Re: [PATCH 00/12] Sumo pull request
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
X-List-Received-Date: Sat, 23 Mar 2019 02:14:51 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

opps, wrong mailing list.



On 3/22/19 7:11 PM, Armin Kuster wrote:
> Please consider this for the next sumo update
>
> The following changes since commit 6d56e912fbbaa22830b4da5ab230586a3d15b23e:
>
>   package_rpm/archiver: Apply bandaid to src.rpm creation (2019-02-25 22:13:08 +0000)
>
> are available in the git repository at:
>
>   git://git.openembedded.org/openembedded-core-contrib stable/sumo-next
>   http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next
>
> Chen Qi (2):
>   systemd: fix CVE-2018-15686
>   systemd: fix CVE-2018-15688
>
> George McCollister (5):
>   systemd: fix CVE-2018-15687
>   systemd: Security fix CVE-2018-16864
>   systemd: Security fix CVE-2018-16865
>   systemd: fix CVE-2018-6954
>   systemd: fix CVE-2019-6454
>
> Marcus Cooper (1):
>   systemd: Security fix CVE-2018-16866
>
> Mingli Yu (1):
>   logrotate.py: restore /etc/logrotate.d/wtmp
>
> ROGEZ Matthieu (1):
>   systemd: Fix typo in root home variable.
>
> Richard Purdie (1):
>   oeqa/runtime/dnf: Fix test error when static libs are enabled
>
> Stefan Agner (1):
>   run-postinsts: for dpkg/opkg, do not rely on /etc/*-postinsts
>
>  meta/lib/oeqa/runtime/cases/dnf.py                 |    2 +-
>  meta/lib/oeqa/runtime/cases/logrotate.py           |    6 +-
>  ...sive-let-s-rework-the-recursive-logic-to-.patch |  252 +++
>  ...eserializing-state-always-use-read_line-L.patch |  250 +++
>  ...sure-we-have-enough-space-for-the-DHCP6-o.patch |   39 +
>  ...n-t-resolve-pathnames-when-traversing-rec.patch |  643 +++++++
>  .../systemd/systemd/0002-Make-tmpfiles-safe.patch  | 1828 ++++++++++++++++++++
>  ...-not-store-the-iovec-entry-for-process-co.patch |  193 +++
>  ...ld-set-a-limit-on-the-number-of-fields-1k.patch |   60 +
>  ...ote-set-a-limit-on-the-number-of-fields-i.patch |   79 +
>  ...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |   49 +
>  .../systemd/systemd/CVE-2019-6454.patch            |  210 +++
>  ...e-receive-an-invalid-dbus-message-ignore-.patch |   61 +
>  meta/recipes-core/systemd/systemd_237.bb           |   13 +-
>  .../run-postinsts/run-postinsts/run-postinsts      |   21 +-
>  .../run-postinsts/run-postinsts.service            |    1 -
>  16 files changed, 3694 insertions(+), 13 deletions(-)
>  create mode 100644 meta/recipes-core/systemd/systemd/0001-chown-recursive-let-s-rework-the-recursive-logic-to-.patch
>  create mode 100644 meta/recipes-core/systemd/systemd/0001-core-when-deserializing-state-always-use-read_line-L.patch
>  create mode 100644 meta/recipes-core/systemd/systemd/0001-dhcp6-make-sure-we-have-enough-space-for-the-DHCP6-o.patch
>  create mode 100644 meta/recipes-core/systemd/systemd/0001-tmpfiles-don-t-resolve-pathnames-when-traversing-rec.patch
>  create mode 100644 meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe.patch
>  create mode 100644 meta/recipes-core/systemd/systemd/0024-journald-do-not-store-the-iovec-entry-for-process-co.patch
>  create mode 100644 meta/recipes-core/systemd/systemd/0025-journald-set-a-limit-on-the-number-of-fields-1k.patch
>  create mode 100644 meta/recipes-core/systemd/systemd/0026-journal-remote-set-a-limit-on-the-number-of-fields-i.patch
>  create mode 100644 meta/recipes-core/systemd/systemd/0027-journal-fix-out-of-bounds-read-CVE-2018-16866.patch
>  create mode 100644 meta/recipes-core/systemd/systemd/CVE-2019-6454.patch
>  create mode 100644 meta/recipes-core/systemd/systemd/sd-bus-if-we-receive-an-invalid-dbus-message-ignore-.patch
>


