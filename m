Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id D317460589
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 17:06:49 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u6JH6mM1009288
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 19 Jul 2016 10:06:48 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.235) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Tue, 19 Jul 2016 10:06:47 -0700
To: "Burton, Ross" <ross.burton@intel.com>, Gary Thomas <gary@mlbassoc.com>
References: <578DC9D2.1060607@mlbassoc.com>
	<9795063.LvlJDZtIeJ@peggleto-mobl.ger.corp.intel.com>
	<578DF132.7020101@mlbassoc.com>
	<CAJTo0LaXhGF3eFt=tfRBHfU56kf_nheBrV8Sshsxrpq+fGn7cA@mail.gmail.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <f4f9f0d1-9827-b239-5458-328a947af066@windriver.com>
Date: Tue, 19 Jul 2016 12:06:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
	Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <CAJTo0LaXhGF3eFt=tfRBHfU56kf_nheBrV8Sshsxrpq+fGn7cA@mail.gmail.com>
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: New progress meters
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
X-List-Received-Date: Tue, 19 Jul 2016 17:06:50 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 7/19/16 11:45 AM, Burton, Ross wrote:
> 
> On 19 July 2016 at 10:21, Gary Thomas <gary@mlbassoc.com
> <mailto:gary@mlbassoc.com>> wrote:
> 
>     Thanks.  I was mostly asking to see what the expected "user experience"
>     should be since the webkitgtk (which takes FOREVER to build) seemed a
>     bit misleading/optimistic.  For the most part, I do like the additional
>     information.
> 
> 
> The situation here is that cmake counts the steps and announces its progress
> through them as the progress.  Of course the last step is to link about 8GB of
> binaries... 
> 
> A progress bar is better than no progress bar, so I still call this an
> improvement :)

We have (had, python 3 broke it) a patch to knotty that permits the logs to be
presented on the screen during a build so for places where you think it might
have hung you can at least get some status.

I like the idea of a progress bar.. but we need to weigh the 'it looks like it
froze' vs 'make sure people know things are still moving'.

in the GUI world this is the old hour glass/spinning cursor/rotating progress
bar -- vs a progress meter behavior..

--Mark

> Ross
> 
> 


