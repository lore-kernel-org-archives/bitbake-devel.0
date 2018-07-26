Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C6B9678B0D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jul 2018 12:51:41 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w6QCpeVn000940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Thu, 26 Jul 2018 13:51:41 +0100
Message-ID: <3dcc3ee348f5e526f58cfdfee5927c3c2d48a9c1.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>, Chris Larson <kergoth@gmail.com>
Date: Thu, 26 Jul 2018 13:51:40 +0100
In-Reply-To: <CA+chaQeSvbBwRUF1qjx2oHi7_h8deiXyanmU9RzhxBF8Ezq0Yg@mail.gmail.com>
References: <1532564810-2025-1-git-send-email-changhyeok.bae@gmail.com>
	<CABcZANmPoDTRWoKCm8w1KL9uw0iNaMCfrM5C8rY_cSCyRDGZMw@mail.gmail.com>
	<CA+chaQeSvbBwRUF1qjx2oHi7_h8deiXyanmU9RzhxBF8Ezq0Yg@mail.gmail.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.4 at dan
X-Virus-Status: Clean
Cc: Changhyeok Bae <changhyeok.bae@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2][1.32] fetch2: fix import error for Python 3.6.5
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
X-List-Received-Date: Thu, 26 Jul 2018 12:51:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2018-07-26 at 08:48 +0200, Martin Jansa wrote:
> Chris: you're right, but it was already merged in this form to
> master, 1.38, 1.36, 1.34 branches, so it would be better to keep the
> same for 1.32.

Agreed, we should have made a better patch and we should really improve
master...

Cheers,

Richard

