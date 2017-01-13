Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 27B7D71D9E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jan 2017 17:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0DH64dr003820; Fri, 13 Jan 2017 17:06:04 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zhezW0HeHfTZ; Fri, 13 Jan 2017 17:06:04 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0DH60EL003798
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Jan 2017 17:06:01 GMT
Message-ID: <1484327160.4367.258.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Bystricky, Juro" <juro.bystricky@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Fri, 13 Jan 2017 17:06:00 +0000
In-Reply-To: <6E51916E4A1F32428260031F4C7CD2B6118F34AD@ORSMSX112.amr.corp.intel.com>
References: <1484264431-28529-1-git-send-email-juro.bystricky@intel.com>
	<1484304882.4367.252.camel@linuxfoundation.org>
	<6E51916E4A1F32428260031F4C7CD2B6118F34AD@ORSMSX112.amr.corp.intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Cc: "jurobystricky@hotmail.com" <jurobystricky@hotmail.com>
Subject: Re: [PATCH] cookerdata.py: check for existence of configuration files
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
X-List-Received-Date: Fri, 13 Jan 2017 17:06:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2017-01-13 at 17:01 +0000, Bystricky, Juro wrote:
> I see your point. The route via a dummy default.conf would require
> having 
> the folder conf/multiconfig present even for users not really
> interested in 
> multiconfig. Not a show stopper, it would be just another file
> created by
> oe-init-build-env. (Another possibility is to have the error check as
> part 
> of sanity checking)

We can put this in meta/conf/mulitconfig, it doesn't have to be in the
build directory.

Cheers,

Richard

