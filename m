Return-Path: <parmesh.iiit@gmail.com>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 2EFF5606BF
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Apr 2015 12:25:37 +0000 (UTC)
Received: by wgsk9 with SMTP id k9so95834637wgs.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 09 Apr 2015 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=jWXe6UIeWkuJvx6mIG4ak8dOUVlNOSCWLDO3KxtsO2E=;
	b=af9d0TVHZJ7mVcWX3DBpQdTBrEQw7S2T2E0vicNl/E3nyMs5Nwo5u9xwWAYt5rffiJ
	Ce1M7Z4Iv7xGkOmi75ULaBukv3BvYvix+y9hZ7dsDWMZ1fwrOgx0RsR6Vrtb6oA0dRxH
	XTdCKktOS+JZft09/IPkV+e2w/rwRrxh09kSsZRZI3i0HYt9SoFrXAJ/rgE1HX+embL1
	ijYR5r68Nbsy21aUfkqYCiht5eY/VgglGcHmSuMTGXqvlUwrBnn68rSVM95VOI0OHzSl
	my/pHEXVNAE51ZTQDzRfmw0MMjpufBkcV6FlATiKqBWshvMJgkVxsOnIm530kxFk4YSf
	mX4g==
MIME-Version: 1.0
X-Received: by 10.194.23.39 with SMTP id j7mr60888160wjf.9.1428582338253; Thu,
	09 Apr 2015 05:25:38 -0700 (PDT)
Received: by 10.180.86.36 with HTTP; Thu, 9 Apr 2015 05:25:38 -0700 (PDT)
Date: Thu, 9 Apr 2015 17:55:38 +0530
Message-ID: <CACBNtJZdWOa1nC9ObOyzrXmhLBgpT-qYaWqTqHdhBWdP56bBGA@mail.gmail.com>
From: parmeshwar tak <parmesh.iiit@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Want to fetch only files which are having ".new" or ".replace" extention to the ${WORKDIR}.
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
X-List-Received-Date: Thu, 09 Apr 2015 12:25:38 -0000
Content-Type: text/plain; charset=UTF-8

Hi All,
I have a simple problem, any one can answer.
I have a repo "rdk\build_script", and branch ="xyz".
I need to write a bbappend where the path "patches/Refsw" has some
files with ".new" and ".replace" extention.

I want to fetch only files which are having ".new" or ".replace"
extention to the ${WORKDIR}.

-- 
Regards
-----------------------------
~Parmeshwar Tak~
MSIT 2010
IIIT Hyderabad

