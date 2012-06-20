Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gopikrishnans@pec.edu>) id 1ShPXU-0004iw-0n
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 20:22:00 +0200
Received: by dalh21 with SMTP id h21so9800919dal.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 11:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding
	:x-gm-message-state;
	bh=Nn/5saCyWGrNAG5GpeF/08MXaGvdgRtXyeHd1yu5fBo=;
	b=GkdOQWd2U0OIkiadvvpgLTW5rzCmNU4Ua6TOhZiVvHk1KeTqtEJJKEbAr4f9Lj1ABX
	cfidCRcKVvZyMdr829EcJT93ORhuTHtqPquvkdAdIhUqkg7S9bTHSIb1D/HIWvJHOgI1
	WFT19U0i+f8iDpMTDLpt6gzZYAd3mPVtdtF+eT5bqxS8JzfNUw3GoNYKcJ7ZDgXcLH4R
	28D4jMRMulr/ZYfXowd9yZLu3smdkbvpnacB7bbah+E/cFYGrcvB57TxS2VWA3NRTtFC
	YxrqkfTwh7zFOo3Bro42ibwbaKIhNq8w4EFGM4DxS/5mNYWdCJpFvJBHvBCchVfJS+tI
	fymw==
Received: by 10.68.220.231 with SMTP id pz7mr69464890pbc.110.1340215874005;
	Wed, 20 Jun 2012 11:11:14 -0700 (PDT)
Received: from [117.231.219.252] ([117.231.219.252])
	by mx.google.com with ESMTPS id tm2sm32701967pbc.69.2012.06.20.11.11.10
	(version=SSLv3 cipher=OTHER); Wed, 20 Jun 2012 11:11:12 -0700 (PDT)
Message-ID: <4FE21245.4010008@pec.edu>
Date: Wed, 20 Jun 2012 23:41:17 +0530
From: Gopi - College <gopikrishnans@pec.edu>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<4FE065F9.6010300@windriver.com> <4FE0B4D8.4020704@pec.edu>
In-Reply-To: <4FE0B4D8.4020704@pec.edu>
X-Gm-Message-State: ALoCoQlk8JRDsAsTD07bf5udAfUOIXQpkvq1GWWZ953NfhOhws8idu/4s4ro4JlkIVrHgxymd4Fi
Subject: p2020rdb - httpd+php
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
X-List-Received-Date: Wed, 20 Jun 2012 18:22:00 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/2012 10:50 PM, Gopi - College wrote:
> Hi,
>        I want to install some light weight web server with PHP on my 
> board. Does openembedded have any repository with webserver and PHP? 
> Or which webserver will be nest suitable for freescale p2020 board.
>
> Reg,
> Gopi



