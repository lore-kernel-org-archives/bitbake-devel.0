Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5D8D9700EB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Apr 2016 10:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u3QAiJMt006828; Tue, 26 Apr 2016 11:44:19 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Tf3kuBWD7E4o; Tue, 26 Apr 2016 11:44:19 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u3QAiHF0006823
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Apr 2016 11:44:18 +0100
Message-ID: <1461667457.31320.160.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ed Bartosh <ed.bartosh@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 26 Apr 2016 11:44:17 +0100
In-Reply-To: <1461572190-17421-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1461572190-17421-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH 1/4] bitbake: main: fix bad-witespace pylint warnings
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
X-List-Received-Date: Tue, 26 Apr 2016 10:44:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This patchset triggered a lively discussion between a few of us about
whether we should or shouldn't make whitespace changes to the codebase.

There is one viewpoint which is that we should state we're aiming for
PEP8 and modify the codebase to match.

Unfortunately there are pieces of API and conventions we have which do
make sense for us and don't match PEP8. For example the use of "d" as
our datastore variable (its a short variable name) or the camelcase in
the datastore methods (getVarFlag) which happens to have worked really
well for the variable dependency analysis.

Personally, I also really don't like unnecessary changes in the history
so that git blame and code annotation get distorted to the whitespace
change commits. I probably spend more time doing that than most.

My general thought is that we should aim for something PEP8 like,
particularly around argument and keyword spacing. I'd prefer to do this
as we add new code or modify existing code and I have been doing that
in my own changes for a while to try and improve consistency.

That said, I personally don't get worked up about line length limits
and even the short variable names aren't that bad, *if* they're limited
in scope to a handful of lines or follow a codebase wide convention (fn
is filename, lf is lockfile, e is exception are the main bitbake ones
that come to mind).

So my feeling is we continue to try and improve the style but not go as
far as large whitespace changes just for the sake of it.

There are some sections which might be worth considering such as Ed's
changes here to the continuation and line too long pieces of main.py
specifically as it is currently a mess. I think the short variable
change may actually confuse some conventions more than fixing them
though.

Certainly I don't want to see a ton of "PEP8" style cosmetic patches
hitting the list.

Cheers,

Richard

