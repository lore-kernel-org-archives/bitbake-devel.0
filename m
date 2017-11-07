Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3898478443
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Nov 2017 13:45:33 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	vA7DjURH013907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 7 Nov 2017 13:45:31 GMT
Message-ID: <1510062330.3952.8.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 07 Nov 2017 13:45:30 +0000
In-Reply-To: <1508844944-5761-4-git-send-email-andr2000@gmail.com>
References: <1508844944-5761-1-git-send-email-andr2000@gmail.com>
	<1508844944-5761-4-git-send-email-andr2000@gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH 3/4] fetch2/repo: Make fetcher always sync on unpack
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
X-List-Received-Date: Tue, 07 Nov 2017 13:45:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2017-10-24 at 14:35 +0300, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Currently if repo has fetched the repository and
> cached it to a tar file it never runs repo sync again,
> thus making the build use potentially outdated repo.
> Fix this by implementing unpack functionality which runs
> repo sync.

This sounds incorrect to me. The unpack task is not meant to touch the
network at all, all network access should be done in the fetch
function.

Cheers,

Richard

