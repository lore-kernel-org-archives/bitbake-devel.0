Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com
	[209.85.216.179])
	by mail.openembedded.org (Postfix) with ESMTP id 70D296E5CB
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Feb 2018 15:04:54 +0000 (UTC)
Received: by mail-qt0-f179.google.com with SMTP id g14so2021335qti.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 07 Feb 2018 07:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:from:date:message-id:subject:to;
	bh=89gsmRjtQOOv0+GICRsbOlDkqsTaGBl/4zIDsFaaGmM=;
	b=YIvj8lR85BFIC4LzgULodRnpLvmsnvkdoSOi2q4MQNldw+D1xTdfothyPO5TDL9yiy
	L96wbgpDzu34cSf4fjNyRA415rkdIQlo5MEHNWTM8o2IJ2WWIUSsqu2+9CRoYLUebs3d
	9sLFGzmkYNzZIK6XF7pLHPl8kuSJaU5LLIRQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=89gsmRjtQOOv0+GICRsbOlDkqsTaGBl/4zIDsFaaGmM=;
	b=GiGnGAwXVDPF7ADyXZo7zR7hcNccSlFKNYAmhAC8HwtbZmgqK+6ni6L5BzotoWKlRK
	S2ErWlis20xrdCwMUOuGip/PRX18AXrj8FGdXR+8FeYgkd2bj+7g5jYAjcYvS882UFqY
	Eqw6RdVleAAK+sHPOEO858L/Lt+ekvcMMAyYbX+q8Fbn814NnM3XpTkDyM5AVRntYVSO
	UpWU50OFnPpnwV2mAwsPIq/swxVj9UkbwRY7Z7Ux6WpKnVVFEHf6NkK400s+TiUZx52y
	YxZ5fRqo83dkesI1XOcgzsHs2YnCaVTL8mF0QMfcKOWpGEm1mMjWJhNmSAJvARb1+wfA
	po7g==
X-Gm-Message-State: APf1xPB78du1/j1S5EFiME/AL+K4a8eAOfwvTmigIV5Tk+z10OjDYIdK
	Ng+NB/DM0cgE/1fR4I5kJCKKICMXoJFUA3CnSRdmR2nvYbo=
X-Google-Smtp-Source: AH8x227O1As8/KNyTO4LlvAXPPcPEcr6VkYOeahqasvaEuOrFWb2C0q37BqWPWi3QpAjwai7qQjgd7CDKzKHlCvel38=
X-Received: by 10.237.45.1 with SMTP id h1mr9800812qtd.34.1518015895297; Wed,
	07 Feb 2018 07:04:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.243 with HTTP; Wed, 7 Feb 2018 07:04:34 -0800 (PST)
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Wed, 7 Feb 2018 16:04:34 +0100
Message-ID: <CAP71WjygD3eM2fhhU5JG6Kn3_y=mH1fzy+aVrQFKtp+ED_yoog@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Ryan Harkin <ryan.harkin@linaro.org>
Subject: git fetcher and github pull requests
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
X-List-Received-Date: Wed, 07 Feb 2018 15:04:55 -0000
Content-Type: text/plain; charset="UTF-8"

hi there,

we've been debugging an issue these days on our builder which ended up
 do_fetch failing with

LANG=C git -c core.fsyncobjectfiles=0 fetch -f --prune --progress
git://github.com/OP-TEE/optee_test.git refs/*:refs/* failed with exit
code 128, output:
error: Could not read 48e440f5f8d033e1ace6e41f424ecf6e6d96e5f2
error: Could not read 019a8db54beb29388e1108831d2e2dc135c1cd73

It happens that these refs correspond to pull requests done on github
which existed at some point, but have been updated with newer commits,
and won't exist anymore.

the bitbake fetcher seems to be greedy and fetches refs/* which ends
up fetching pull request when fetching from github, e.g. in my
workspace:

in $DL_DIR/git2/

github.com.docker.containerd.git/refs/pull/66
github.com.docker.containerd.git/refs/pull/459
github.com.docker.containerd.git/refs/pull/551
github.com.docker.containerd.git/refs/pull/321
github.com.docker.containerd.git/refs/pull/60
github.com.docker.containerd.git/refs/pull/523
github.com.docker.containerd.git/refs/pull/40
github.com.docker.containerd.git/refs/pull/561

It looks inefficient to fetch and store on each builder pull requests.
I understand this is just because how PR are implemented in github,
but github is quite central, so many we should/could do something
about it?

Beyond the inefficiencies, we now are seeing unrelated build issues as well.

What do you think? Should we try to avoid fetching refs/pull/* from
github? or is it our git fetch command that needs to be improve to
work in this situation?

thanks
nico

