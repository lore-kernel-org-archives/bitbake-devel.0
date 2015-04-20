Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 9D01E6AC24
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Apr 2015 13:59:28 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP; 20 Apr 2015 06:59:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,609,1422950400"; d="scan'208";a="483163026"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com) ([10.252.5.75])
	by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2015 06:59:29 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Trevor Woerner <twoerner@gmail.com>
Date: Mon, 20 Apr 2015 14:59:28 +0100
Message-ID: <2018522.0gSfKPRhqs@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.4 (Linux/3.18.9-200.fc21.x86_64; KDE/4.14.6; x86_64; ; )
In-Reply-To: <5535032B.4000007@gmail.com>
References: <cover.1429280244.git.paul.eggleton@linux.intel.com>
	<54b162c649388c63015cdd0d69866d5604303b60.1429280244.git.paul.eggleton@linux.intel.com>
	<5535032B.4000007@gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] lib/bb/utils: add safeguard against recursively deleting things we shouldn't
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
X-List-Received-Date: Mon, 20 Apr 2015 13:59:32 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 20 April 2015 09:46:19 Trevor Woerner wrote:
> On 15-04-17 10:26 AM, Paul Eggleton wrote:
> > Add some very basic safeguard against recursively deleting paths such
> > as / and /home in the event of bugs or user mistakes.
> 
> I liked Nicolas Dechesne's idea of only allowing deletion in paths that
> include TMPDIR or TOPDIR. Is there any reason bitbake would need to
> delete (potentially dangerous) paths anywhere else?

Unfortunately this would be problematic for people who decide to split out 
directories managed by the build system to different paths (which they often do 
when part of the system has to be shared over NFS, or to put part of TMPDIR on 
a larger disk, or spread between SSDs and rotational media, etc.). Another 
issue is that the functions in question don't actually have access to d (the 
datastore) and thus can't actually get the value of these variables, at least 
with the way the code is currently structured.

> With a list-based approach the list will keep growing indefinitely.
> Inevitably an ex-Solaris person will come along (for example) and have
> their /home directories in /export/home and need a patch for that, etc,
> etc...

It's not all-encompassing, I agree. I'm all for improving it but unfortunately 
restricting to TMPDIR/TOPDIR will break for a lot of users.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

