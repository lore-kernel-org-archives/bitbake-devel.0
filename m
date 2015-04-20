Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D8433738F4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Apr 2015 22:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3KM58gD032360; Mon, 20 Apr 2015 23:05:08 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lAJ8mMRrKf3S; Mon, 20 Apr 2015 23:05:08 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3KM4rWq032342
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 20 Apr 2015 23:05:04 +0100
Message-ID: <1429567493.26983.54.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Mon, 20 Apr 2015 23:04:53 +0100
In-Reply-To: <2018522.0gSfKPRhqs@peggleto-mobl.ger.corp.intel.com>
References: <cover.1429280244.git.paul.eggleton@linux.intel.com>
	<54b162c649388c63015cdd0d69866d5604303b60.1429280244.git.paul.eggleton@linux.intel.com>
	<5535032B.4000007@gmail.com>
	<2018522.0gSfKPRhqs@peggleto-mobl.ger.corp.intel.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
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
X-List-Received-Date: Mon, 20 Apr 2015 22:05:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-04-20 at 14:59 +0100, Paul Eggleton wrote:
> On Monday 20 April 2015 09:46:19 Trevor Woerner wrote:
> > On 15-04-17 10:26 AM, Paul Eggleton wrote:
> > > Add some very basic safeguard against recursively deleting paths such
> > > as / and /home in the event of bugs or user mistakes.
> > 
> > I liked Nicolas Dechesne's idea of only allowing deletion in paths that
> > include TMPDIR or TOPDIR. Is there any reason bitbake would need to
> > delete (potentially dangerous) paths anywhere else?
> 
> Unfortunately this would be problematic for people who decide to split out 
> directories managed by the build system to different paths (which they often do 
> when part of the system has to be shared over NFS, or to put part of TMPDIR on 
> a larger disk, or spread between SSDs and rotational media, etc.). Another 
> issue is that the functions in question don't actually have access to d (the 
> datastore) and thus can't actually get the value of these variables, at least 
> with the way the code is currently structured.
> 
> > With a list-based approach the list will keep growing indefinitely.
> > Inevitably an ex-Solaris person will come along (for example) and have
> > their /home directories in /export/home and need a patch for that, etc,
> > etc...
> 
> It's not all-encompassing, I agree. I'm all for improving it but unfortunately 
> restricting to TMPDIR/TOPDIR will break for a lot of users.

I liked his idea too however we use these functions against SSTATE_DIR
and DL_DIR which are often not in TMPDIR/TOPDIR. Yes, we could start
making a list of exceptions but I don't think it will scale well, not
withstanding the other technical issues Paul mentions.

Cheers,

Richard


