Return-Path: <paul.barker.commagility@gmail.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id C574E60125
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Nov 2015 17:23:44 +0000 (UTC)
Received: by wmff134 with SMTP id f134so64880299wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 02 Nov 2015 09:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=date:from:to:subject:message-id:organization:mime-version
	:content-type:content-transfer-encoding;
	bh=X+Fe4RABzZk64YdkfBEaqUk97iVoGvyfgjaNeoc098k=;
	b=NGhLoMi0QSoU5yXwlPmXMxiNzVXds5thU08YEXGtb8oW8yKkt0GshdFouRN02qVPWO
	qOJ9TrQqB2Bv1TjIkZ7wF5GONZ4dAjvK2dA70msN22VeHZRtFq+jOKxCH8yyQ5kN91l2
	jV9KMS48WpLfp26ivu2n8c/afylyQAHrK3kSUByviWDCcjUST/ondvV7EdRgv3c2Rs2r
	QbnnyozhqnnNu1CvOpqEfr8wnMftJ7TENbYO3v8JnlLg+K8FMoQaMgd4goQLibZxD6km
	e+J1tFv1Rj9wPj9Bbp0mID7Hw+BEE6/ghoIYZ/0sqNx6R8PIU61zlViPKjbU/vqFaHxN
	N1Hg==
X-Received: by 10.28.9.73 with SMTP id 70mr15612863wmj.42.1446485024893;
	Mon, 02 Nov 2015 09:23:44 -0800 (PST)
Received: from centos-7 (inno-commagility-ownrouter.lut.ac.uk. [131.231.60.35])
	by smtp.gmail.com with ESMTPSA id
	ki7sm23393688wjc.28.2015.11.02.09.23.43
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 02 Nov 2015 09:23:43 -0800 (PST)
Date: Mon, 2 Nov 2015 17:23:29 +0000
From: Paul Barker <paul.barker@commagility.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20151102172329.6e291d50@centos-7>
Organization: CommAgility Ltd
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.22; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Subject: Combining bitbake 1.26 with daisy
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
X-List-Received-Date: Mon, 02 Nov 2015 17:23:46 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

If someone were to pick up bitbake 1.26 and the daisy branch of oe-core and try
to use these together, what would be likely to go wrong?

I've got a vendor's BSP which does this and I need to decide whether to use the
combination they've tested or move back to bitbake 1.22. I sadly don't think
it's possible to move forward from daisy to fido here. I don't mind fixing up
the issues myself, just wondering if anyone has an idea of what is likely to
fail.

Thanks,

-- 
Paul Barker
CommAgility Ltd

