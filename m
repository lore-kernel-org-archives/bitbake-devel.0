Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1TDldP-0005Qc-81
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 02:25:51 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8I0DA56029864
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 17:13:10 -0700 (PDT)
Received: from Marks-MacBook-Pro.local (147.11.119.60) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.309.2; Mon, 17 Sep 2012 17:13:10 -0700
Message-ID: <5057BC95.5070704@windriver.com>
Date: Mon, 17 Sep 2012 19:13:09 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8;
	rv:15.0) Gecko/20120907 Thunderbird/15.0.1
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
	<1347921818-60562-3-git-send-email-jason.wessel@windriver.com>
In-Reply-To: <1347921818-60562-3-git-send-email-jason.wessel@windriver.com>
Subject: Re: [PATCH 2/8] knotty.py: Extend knotty to support "real time" log tail for tasks
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
X-List-Received-Date: Tue, 18 Sep 2012 00:25:51 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/12 5:43 PM, Jason Wessel wrote:
> This patch provides the capability to knotty to have a higher log
> level where the individual tasks logs can be multiplexed to stdio.
> This is highly desirable for several different use cases.
>
> 1) You can visually spot "hot spots" in building parallel tasks
>
> 2) The relative order an sequence of events can be determined in
>     difficult to diagnose inter-related library problems.
>
> 3) It provides a nice way to see what all is actually going on and
>     getting logged by various tasks such as a kernel compile where you
>     might want to actually look at the output in a build over build
>     scenario.
>
> 4) There are most certainly other aspects where this is useful.
>
> The primary control is to set the BB_RT_LOGLEVEL = "2" in your
> local.conf.  Additional capabilities will follow in successive
> patches.  When parallel tasks are enabled, the logs will be
> multiplexed and prefixed with the PID of the task.  In the
> non-parallel case there is no PID prefix as everything is linear.
>
> (LOCAL REV: NOT UPSTREAM)

As any FYI, this adds the new BB_RT_LOGLEVEL.  If this patch is applied, then 
BB_RT_LOGLEVEL should be added to BB_HASHCONFIG_WHITELIST in bitbake.conf.

--Mark



