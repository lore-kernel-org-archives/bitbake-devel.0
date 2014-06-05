Return-Path: <ashcharles@gmail.com>
Received: from mail-vc0-f173.google.com (mail-vc0-f173.google.com
	[209.85.220.173])
	by mail.openembedded.org (Postfix) with ESMTP id 68C6B6FA7C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Jun 2014 19:14:55 +0000 (UTC)
Received: by mail-vc0-f173.google.com with SMTP id ik5so1702728vcb.32
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 Jun 2014 12:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=58GkGZApOnqLU7zU2oR5visly+I6oSig7yfylB9/JIU=;
	b=kAyLwY5CDF6aWxDU09RRxL2Y5GICylqi5wR081RurnxABdDDfFmT4f9WuwL4F53RHq
	BN/vVDO/vByCbzzklotSm4ppZOHOZF/rJxhtmy1CqVKypscAnp+kjw7A0hdM7BrO2LsP
	vmu7DQzitC0FbhsoPcC9/qMkd+gkfkAyEZ+uDC7DR99zTyRCdsEXKFhmD24a+Ealoxup
	HFVITJFKEVZQvpFsJlhDZnWfTbnKRDvecWljqD1ZuL/NoEaKVYhSZrZT7MpQVfhAXbzQ
	c/5K5k3LlscdR3fJiSNoZdgMtr8xuX1+LjUzu/SreP7/vwOqpqnwc7Wjqt0DvAzq5lA5
	6wMQ==
X-Received: by 10.53.12.229 with SMTP id et5mr24253105vdd.32.1401995696765;
	Thu, 05 Jun 2014 12:14:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.58.227.67 with HTTP; Thu, 5 Jun 2014 12:14:26 -0700 (PDT)
From: Ash Charles <ashcharles@gmail.com>
Date: Thu, 5 Jun 2014 12:14:26 -0700
Message-ID: <CAK8F28=zftQQKQymrxk_Zu_3ttURMFEW+0szvXeC+XhQjHT=_w@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: bitbake-layers show-appends doesn't show wildcarded appends
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
X-List-Received-Date: Thu, 05 Jun 2014 19:14:59 -0000
Content-Type: text/plain; charset=UTF-8

Hi,

I just tried using bitbake-layers show-appends but I don't see
wildcarded bbappends in the list.

e.g. if I have a bbappend named eglinfo_%.bbappend, it doesn't show up if I do
$ bitbake-layers show-appends
but it does show up if I change the file name to eglinfo_1.0.bbappend
(as '1.0' is the current version).

Regardless of the file name, the bbappend is used.

--Ash

