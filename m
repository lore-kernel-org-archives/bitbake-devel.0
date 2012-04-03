Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SFDff-0007CD-J1
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Apr 2012 02:01:55 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 03 Apr 2012 16:52:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="128399489"
Received: from unknown (HELO [10.255.12.117]) ([10.255.12.117])
	by orsmga002.jf.intel.com with ESMTP; 03 Apr 2012 16:52:44 -0700
Message-ID: <4F7B8D4C.5070906@linux.intel.com>
Date: Tue, 03 Apr 2012 16:52:44 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1333155656.git.josh@linux.intel.com>
In-Reply-To: <cover.1333155656.git.josh@linux.intel.com>
Subject: Re: [PATCH 0/1] Error gracefully on systems which don't support Hob
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
X-List-Received-Date: Wed, 04 Apr 2012 00:01:55 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I have a more informative version of this patch which I'll submit shortly.

On 30/03/12 18:05, Joshua Lock wrote:
> Hob requires pygtk 2.22 or later and systems without that will see a Python
> backtrace.
> This small change tests whether pygtk is installed and tests which version of it
> is available and prints an error if pytgtk is missing or too low a version.
>
> Cheers,
> Joshua
>
> The following changes since commit 035e146ff92236a3eda71ad71e8389737f91753b:
>
>    Hob: In building log page, fixed the issue about 'endpath' not clear when next to start build (2012-03-30 17:19:35 +0100)
>
> are available in the git repository at:
>    git://github.com/incandescant/bitbake josh/hob
>    https://github.com/incandescant/bitbake/tree/josh/hob
>
> Joshua Lock (1):
>    lib/bb/ui/hob: exit cleanly if the required pygtk version isn't
>      available
>
>   lib/bb/ui/hob.py |   11 +++++++++--
>   1 files changed, 9 insertions(+), 2 deletions(-)
>

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


