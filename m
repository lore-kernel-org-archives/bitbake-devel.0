Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id D3D8460125
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Oct 2015 18:44:58 +0000 (UTC)
Received: by wikq8 with SMTP id q8so45332920wik.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Oct 2015 11:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:cc:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-type
	:content-transfer-encoding;
	bh=zGkN2aDschr4hYxzQ9ZtUGKeYUeAgzyXPWjeuc2dV98=;
	b=FlsjotAwxKo0nqpJjUBOLLI5kLMvdIh6pMUkYhqnKv2rljUMmdtgrUyza/3zAA2TWf
	+u/e92F5Nnbf4SNqwPpRqxUE77syuXeAuqfqgm/sK/3A4UfCir04p5uBnwoKS9rQno3G
	dFzyAIViG+0GJ+OpwbyQhVYKN5AlLdHA91gnFbxz2LvCr5kKVVkkzw15VLmZv3vBnqdw
	f2nb95qC7geBYi328ESJyyT4weUflNgmhgDSJlg3iljjid2ITlejEfwOw+dz29MTdi53
	LEMOPjr8xE9Nh8S390JlvOYCX05EXcPk5k1hrtz6EBLGBE9/C29hF9JSQoHK0gYFD+U7
	bltw==
X-Gm-Message-State: ALoCoQmZdQsDbXBE0B1PDR97ivUzXtLhkH5HXB7ZvK4Up2HbXqFzpImtcEP2kfGjwRx+eP/bMQbK
X-Received: by 10.180.77.9 with SMTP id o9mr18629257wiw.71.1445539498453;
	Thu, 22 Oct 2015 11:44:58 -0700 (PDT)
Received: from [192.168.0.22] (0543d9db.skybroadband.com. [5.67.217.219])
	by smtp.googlemail.com with ESMTPSA id
	pb4sm18398149wjb.8.2015.10.22.11.44.57
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 22 Oct 2015 11:44:57 -0700 (PDT)
To: Paul Barker <paul.barker@commagility.com>,
	bitbake-devel@lists.openembedded.org
References: <1445523709-17314-1-git-send-email-paul.barker@commagility.com>
From: Michael Wood <michael.g.wood@intel.com>
Message-ID: <56292EA8.8050901@intel.com>
Date: Thu, 22 Oct 2015 19:44:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1445523709-17314-1-git-send-email-paul.barker@commagility.com>
Subject: Re: [PATCH][1.26] Backport toaster fix from master
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
X-List-Received-Date: Thu, 22 Oct 2015 18:44:59 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/15 15:21, Paul Barker wrote:
> This is a backport of commit b4ce793685f70cab3f28cb4329aaaf3878cd62e8 from
> master, re-written as `git cherry-pick` couldn't figure it out. I'm unsure if
> this is the right way to send it as I'm not the auther of the original patch. I
> can edit the authorship to credit Michael Wood and resubmit if desired - as I've
> altered the patch I didn't want to put his name on it initially.
>
> This fixes issues I've been seeing in toaster with packages missing from the
> "Packages included" list and an empty "Directory structure" page for my images
> when using fido and bitbake 1.26.
>
> Paul Barker (1):
>    toaster: buildinfohelper Skip packages we have no build info about
>
>   lib/bb/ui/buildinfohelper.py | 40 ++++++++++++++++++++++++++++------------
>   1 file changed, 28 insertions(+), 12 deletions(-)
>

All fine by me.

Thanks,

Michael

