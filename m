Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SzWyB-0005PP-1w
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Aug 2012 19:56:27 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q79HiaTW016350
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 9 Aug 2012 10:44:36 -0700 (PDT)
Received: from e6410-2 (172.25.40.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Thu, 9 Aug 2012 10:44:36 -0700
Date: Thu, 9 Aug 2012 12:44:25 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Message-ID: <20120809124425.797f12fa@e6410-2>
In-Reply-To: <1356576.1YqSGvrhCQ@helios>
References: <cover.1344467794.git.peter.seebach@windriver.com>
	<9005aeb8b41113f05121842055434fdeeda8c63c.1344467794.git.peter.seebach@windriver.com>
	<1356576.1YqSGvrhCQ@helios>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] cooker.py: Remove explicit build targets from the ignored list
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 09 Aug 2012 17:56:27 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Thu, 9 Aug 2012 18:30:57 +0100
Paul Eggleton <paul.eggleton@linux.intel.com> wrote:

> I'd rather we not change it to behave this way - the better approach
> would seem to me to be to just print a warning that the requested
> target is in ASSUME_PROVIDED and then not do anything else; if the
> user really wants to build the thing they can just remove it from
> ASSUME_PROVIDED.

Removing things from ASSUME_PROVIDED can be a bit tricky, because they
can come from more than one place. And it may not be easy to see where
they came from. (In my most convenient build, there are at least two
files setting ASSUME_PROVIDED.)

> If there is a genuine need to be able to force an item in
> ASSUME_PROVIDED to be built I'd probably want to hear a bit more
> background.

I think it's not so much that there's a need, as that an explicit
statement should win over an assumption.

Analogy time!  Which is a better response to "-O2 -fno-inline":
1. Error message explaining that -O2 implied -finline, so you can't
do that.
2. The explicit flag overrides the flags implied by -O2.

I think of ASSUME_PROVIDED as meaning "if something thinks it needs
this, assume it's already available". So don't build it by-implication,
for instance as a dependency. Thus the name "ignored_dependencies".
Things specified by the user on the command line aren't dependencies,
though. They're explicit requests, and I think those should win. That
said... It might make sense to add a:

bb.note("Explicit target '%s' overriding ASSUME_PROVIDED." % foo)

so that people are aware that they are doing something unusual.

The specific case that got me looking at this actually involved the
bitbake -e feature, and on the one hand, seeing no output was
confusing, on the other hand, a diagnostic warning me that Something
Strange was involved would actually have been pretty informative.

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.


