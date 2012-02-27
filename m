Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S2APt-0008FR-BR
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Feb 2012 00:55:41 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 27 Feb 2012 15:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="122180238"
Received: from unknown (HELO helios.localnet) ([10.252.123.58])
	by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2012 15:45:49 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: McClintock Matthew-B29882 <B29882@freescale.com>
Date: Mon, 27 Feb 2012 23:45:47 +0000
Message-ID: <2548258.gq2qYr9CFK@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.0 (Linux/3.0.0-16-generic-pae; KDE/4.8.0; i686; ; )
In-Reply-To: <CAEsOVNdC8Xh4E32Lep8g0BjNXFQHJzGVZ3s3gTied6UYqNnCYA@mail.gmail.com>
References: <cover.1330368761.git.paul.eggleton@linux.intel.com>
	<67b6b60673a682f1d76aa224e0e47e1ca83f5bc9.1330368761.git.paul.eggleton@linux.intel.com>
	<CAEsOVNdC8Xh4E32Lep8g0BjNXFQHJzGVZ3s3gTied6UYqNnCYA@mail.gmail.com>
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/2] bitbake: fix setscene task start/failure handling
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
X-List-Received-Date: Mon, 27 Feb 2012 23:55:41 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 27 February 2012 19:15:46 McClintock Matthew-B29882 wrote:
> On Mon, Feb 27, 2012 at 12:54 PM, Paul Eggleton
> 
> <paul.eggleton@linux.intel.com> wrote:
> > +            if isinstance(event, bb.runqueue.sceneQueueTaskFailed):
> > +                logger.warn("Setscene task %s (%s) failed with exit code
> > '%s' - real task will be run instead", +                            
> > event.taskid, event.taskstring, event.exitcode)
> This removes the "ERROR:" message, right?

If a failure logs an ERROR itself then no, this would still be printed. 
However, in the case of an error situation such as one I simulated (unable to 
read from the sstate-cache file) nothing was being printed at all, which is not 
particularly helpful. Thus this part of the change.

Cheers,
Paull

-- 

Paul Eggleton
Intel Open Source Technology Centre


