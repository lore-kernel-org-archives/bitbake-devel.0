Return-Path: <saul.wold@intel.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
	[209.85.220.51])
	by mail.openembedded.org (Postfix) with ESMTP id 1F01265D3D
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 May 2014 16:48:38 +0000 (UTC)
Received: by mail-pa0-f51.google.com with SMTP id kq14so4521025pab.38
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 May 2014 09:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:message-id:date:from:organization:user-agent
	:mime-version:to:subject:content-type:content-transfer-encoding;
	bh=uqKhxAsMjJUYEvmYel2XFHyLSS4BIlBP6qjD3gV/aCE=;
	b=SbuVerb6SemgSOONOZQ2n+g3YimbdjRWZhD/Tcf11fl0yjGaQPSdJuGbUFvnI17jIr
	a2zOcalVczZBU9otcj/fH73+Sq+WdXfctVzAInSiQL7FZd6G52tkuXcThTC86XtWMYwT
	vFeel0Sc8I16C39ifpDV5ItllaKUS2meX0snmXOFj2uQsoPqOnBwp8hd3vnojb1vEHqq
	5yq6c/cftKS0IHI9xQVdBFJb3/WRJJbdbESq+H3k7oyfNQ8gkUmk+VxUJb3+ubLGyiMH
	MqqZFU8t3iUjEhzpfrvnr1Ogdt9EbyE1EIHq7XYejFyK8CyBUn4queT5pAICeurHuKv0
	0mRQ==
X-Gm-Message-State: ALoCoQkoTHHP+BD/FZyddItm73bydHHsSrhtfAm/PPaiHd41xp+scUu+Lt2NwIazye5ymMOWIYoC
X-Received: by 10.66.136.103 with SMTP id pz7mr8220553pab.140.1399394919765;
	Tue, 06 May 2014 09:48:39 -0700 (PDT)
Received: from [10.6.18.24] (c-50-186-0-160.hsd1.or.comcast.net.
	[50.186.0.160]) by mx.google.com with ESMTPSA id
	iq10sm1393660pbc.14.2014.05.06.09.48.38 for <multiple recipients>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 06 May 2014 09:48:39 -0700 (PDT)
Message-ID: <53691266.2090107@intel.com>
Date: Tue, 06 May 2014 09:48:38 -0700
From: Saul Wold <saul.wold@intel.com>
Organization: Intel
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To: 'Patches and discussions about the oe-core layer'
	<openembedded-core@lists.openembedded.org>, 
	Yocto Project Discussion <yocto@yoctoproject.org>, 
	"poky@yoctoproject.org" <poky@yoctoproject.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
X-Mailman-Approved-At: Tue, 20 May 2014 10:33:43 +0000
Subject: Daisy Stable Branch - open for patch suggestions
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
X-List-Received-Date: Tue, 06 May 2014 16:48:42 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


[Sorry for the overlap, want to make sure I hit a broad audience]

Hi Everyone!

I will be the stable maintainer for the Daisy branch, and it is now open 
for suggestions of backport patches.  I am starting to generate a list 
of patches that are already in master.

The following wiki page has the Policies and process for requesting a 
fix in a stable branch, please review that before sending a patch.

https://wiki.yoctoproject.org/wiki/Stable_branch_maintenance

Please remember to include [daisy] in any request (backport or commit).

We do not have a hard date for this yet, but likely be in late May - 
early June time frame for the 1.6.1 release.

Thanks to all for your efforts.

Sau!

