Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S3829-0001EX-OI for bitbake-devel@lists.openembedded.org;
	Thu, 01 Mar 2012 16:35:09 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q21FQb47018018;
	Thu, 1 Mar 2012 15:26:37 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17710-04; Thu,  1 Mar 2012 15:26:33 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q21FQTI8018012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Mar 2012 15:26:30 GMT
Message-ID: <1330615593.31767.14.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Thu, 01 Mar 2012 15:26:33 +0000
In-Reply-To: <cover.1330613733.git.paul.eggleton@linux.intel.com>
References: <cover.1330613733.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] Fixes for scenequeue task failure
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
X-List-Received-Date: Thu, 01 Mar 2012 15:35:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-03-01 at 14:57 +0000, Paul Eggleton wrote:
> After some more extensive testing, fix some regressions in scenequeue
> task failure handling caused by one of my earlier commits.
> 
> The following changes since commit 8f07bdc0a42dd7a7c3acf5d1b13220dbc98c8017:
> 
>   image_types_uboot: Update to work after recent image_types changes (2012-02-29 18:25:03 +0000)
> 
> are available in the git repository at:
>   git://git.yoctoproject.org/poky-contrib paule/bb-sceneqtaskfail
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-sceneqtaskfail
> 
> Paul Eggleton (3):
>   bitbake/runqueue: fix python error on scenequeue task failure
>   bitbake/uihelper: restore line to record failed normal tasks
>   bitbake/build: report TaskFailedSilent events as "Failed"

Merged to master, thanks.

Richard



