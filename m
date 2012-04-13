Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SIkAO-0006X7-Kq
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 19:20:12 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 13 Apr 2012 10:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130638862"
Received: from unknown (HELO [10.255.12.191]) ([10.255.12.191])
	by azsmga001.ch.intel.com with ESMTP; 13 Apr 2012 10:10:49 -0700
Message-ID: <4F885E19.6050605@linux.intel.com>
Date: Fri, 13 Apr 2012 10:10:49 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1334275549.git.josh@linux.intel.com>
In-Reply-To: <cover.1334275549.git.josh@linux.intel.com>
Subject: Re: [RFC PATCH 0/3] Replace HobNotebook with gtk.Notebook
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
X-List-Received-Date: Fri, 13 Apr 2012 17:20:12 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've figured out how to composite things so the artefact is gone. 
Updated patchset shortly!

Thanks,
Joshua

On 12/04/12 17:10, Joshua Lock wrote:
> The important patch in this RFC is the first which replaces the fully custom
> HobNotebook with a simpler gtk.Notebook subclass.
>
> It's an RFC as there's currently what looks like a rendering glitch in how the
> tabs are displayed. See the white boxes in the tabs of this screenshot:
> https://bugzilla.yoctoproject.org/attachment.cgi?id=465
>
> I'm researching how to remove this artifact but wanted to gather feedback on the
> patch as it stands as we are close to the checkin deadline.
>
> Thanks,
> Joshua
>
> The following changes since commit 3c2808b67384e92601cbd66877c36ca40df7c7ba:
>
>    Hob: fix the missing functions (2012-04-12 15:56:42 +0100)
>
> are available in the git repository at:
>    git://github.com/incandescant/bitbake josh/hob
>    https://github.com/incandescant/bitbake/tree/josh/hob
>
> Joshua Lock (3):
>    lib/bb/ui/crumbs/: replace custom HobNotebook
>    lib/bb/ui/crumbs/hobwidget: use light text in HobIndicator
>    lib/bb/ui/crumbs/imageconfiguration: fix combo boxes drop-down width
>
>   lib/bb/ui/crumbs/builddetailspage.py       |    4 +-
>   lib/bb/ui/crumbs/hobwidget.py              |  468 +++++-----------------------
>   lib/bb/ui/crumbs/imageconfigurationpage.py |    2 -
>   lib/bb/ui/crumbs/packageselectionpage.py   |    3 +-
>   lib/bb/ui/crumbs/recipeselectionpage.py    |    5 +-
>   5 files changed, 82 insertions(+), 400 deletions(-)
>

-- 
Joshua Lock
         Yocto Project
         Intel Open Source Technology Centre


