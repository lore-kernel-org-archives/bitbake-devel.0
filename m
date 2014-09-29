Return-Path: <Konrad.Scherer@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 59B8360809
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Sep 2014 15:22:03 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id s8TFM4Wj009741
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Sep 2014 08:22:04 -0700 (PDT)
Received: from [128.224.56.217] (128.224.56.217) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.174.1;
	Mon, 29 Sep 2014 08:22:03 -0700
Message-ID: <5429791A.3010405@windriver.com>
Date: Mon, 29 Sep 2014 11:22:02 -0400
From: Konrad Scherer <konrad.scherer@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.1.2
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <20140926220153.GA29668@bshelton-desktop>
In-Reply-To: <20140926220153.GA29668@bshelton-desktop>
X-Originating-IP: [128.224.56.217]
Subject: Re: Getting bitbake_prserv database contents to persist across power loss
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
X-List-Received-Date: Mon, 29 Sep 2014 15:22:11 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

On 09/26/2014 06:01 PM, Ben Shelton wrote:
> Hi all,
>
> We're currently running a shared PR server that is used by all the
> OpenEmbedded build machines on our intranet (both for developers'
> machines and for nightly build machines).
>
> We recently ran into an issue where the blade that the shared PR server
> runs on was shut down unexpectedly and the PR history since the PR
> server was last restarted was not committed to disk.  Looking at the
> commit 'prserv: Ensure data is committed', it looks like the only times
> the transactions are committed is when the PR server process is shut
> down.
>
> What would be your guidance in this case?  Should we just shut down /
> restart the PR server nightly to save off the data?  If we wrote a patch
> to the PR server to commit the data to the database at runtime-specified
> intervals, would that be something we could upstream?

It occurred to me a while ago, that it may be possible to recreate PR server 
data from an sstate-cache. The sstate file for the deploy-rpm task contains the 
rpms and each rpm contains the PR number. The rest of the PR server fields like 
checksum can be retrieved from the sstate filename or siginfo. Unfortunately I 
have not written the script or I would be happy to share it with you.

Has anyone tried this? Am I missing something important? A script that does this 
would help in situations like this.

-- 
Konrad Scherer, MTS, Linux Products Group, Wind River

