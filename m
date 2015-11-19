Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id ED7D16010D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 12:26:29 +0000 (UTC)
Received: by wmec201 with SMTP id c201so115451049wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:subject:to:message-id:date:user-agent:mime-version
	:content-type:content-transfer-encoding;
	bh=/HzwLb/QscIF+dZbC5v+yYwmPpLkcJIj0D6yyfNGhqU=;
	b=WDVraux405nEk4rmG+6GntDc4DQ7j4LEzxcp0Mh6lU/6xNcboC5WNmGbxBbRbX77Mm
	TTudk+mDQTdzNoxde4x5baIw2SLAGzDqy6U8pzWGtk8wBBzrKMmgw75JsiRkl6Dc3iTC
	LsbfaPmw0w+smD6xh621RRdj72IMHmb1A81P6yUGN8GLsX+MMyJh5/cgW322wJrG0tIM
	t27jYWW+WziNe9sAQmz9Xg3S+il/8oNanzwZ5Jhl5CtmFXvGTeVO3gG07dGFC15oF2+H
	zb51oxMqdw5G7z8sOyS+0MofjMPxvl3N8rPhAewMZzMdzDDHnvTsDIpQNSp/xCNuU+Ux
	64yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:subject:to:message-id:date:user-agent
	:mime-version:content-type:content-transfer-encoding;
	bh=/HzwLb/QscIF+dZbC5v+yYwmPpLkcJIj0D6yyfNGhqU=;
	b=J5qK6TV0g7pHZmYjNvzNV0Ojx9g9bDGCxTifBVZ66PIM6caYi+NzAX3ifjionUamhZ
	XUuT7kJiokgcQat8af3q2Ze1zZ7fOzL7ioRGOx0+plkafCQI/UJR8O2hdwyUi0oLxje/
	61owmbP2Q9upEN7oFmzZKZFnK08+z0NOHFQRgZSVDp08geJ19DY8H3rq8w0wxhoLCAMX
	hC5BXWLYfTOE1IHK7NTssV4fylKrCvPpSQgGxWD85wzxcugzxWC/Q0VXvC/e9UkINR4q
	OOQcPZfPjINqfvZkfaZ5dYZePEi3E/CjhiaJW1Oonq8McmeF07OaE7osXAz9yt2oOkkc
	GKBg==
X-Gm-Message-State: ALoCoQmXElEb9tr74SDraOZASD1eHO+HgSqKofxreQJyPGqvmpb1QimgtpQM/L8PGgV9xXRQSF1a
X-Received: by 10.28.61.4 with SMTP id k4mr10718079wma.34.1447935989744;
	Thu, 19 Nov 2015 04:26:29 -0800 (PST)
Received: from [192.168.2.10] ([83.217.123.106])
	by smtp.googlemail.com with ESMTPSA id
	cv3sm7689563wjc.20.2015.11.19.04.26.28
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 19 Nov 2015 04:26:28 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <564DBFF3.9090003@intel.com>
Date: Thu, 19 Nov 2015 12:26:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
Subject: Retrieving values for project configuration
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
X-List-Received-Date: Thu, 19 Nov 2015 12:26:30 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In Toaster we present users with a list of 'valid' values for 
IMAGE_FSTYPES, currently this is manually copied from the image_types 
class[1] and often gets out of date because of this. Is there any way 
for Toaster to programmatically retrieve the list?

We will have a similar issue with getting correct values for 
PACKAGE_CLASSES, IMAGE_FEATURES and MACHINE_FEATURES

Thanks,

Michael

[1] 
http://cgit.openembedded.org/openembedded-core/tree/meta/classes/image_types.bbclass#n214 


