Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id ACE067900B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Aug 2018 08:34:16 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w7K8YEuM010493
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 20 Aug 2018 01:34:15 -0700 (PDT)
Received: from localhost.corp.ad.wrs.com (128.224.162.161) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.399.0; Mon, 20 Aug 2018 01:34:14 -0700
To: "Slaev, Ivan" <Ivan.Slaev@harman.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <be55ff135cbc4483ab4483660d5a0870@HIMDWSMB03.ad.harman.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <0c871f0a-d068-9870-c932-a55ea1514aa6@windriver.com>
Date: Mon, 20 Aug 2018 16:37:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <be55ff135cbc4483ab4483660d5a0870@HIMDWSMB03.ad.harman.com>
Subject: Re: mistake in chapter 2.1
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
X-List-Received-Date: Mon, 20 Aug 2018 08:34:16 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 08/17/2018 07:55 PM, Slaev, Ivan wrote:
> Dear bitbake-devel (community) :),
> 
> While I was reading the 2.1 chapter of bitbake manual, I thing I found a mistake in:
> 
> The |layer.conf| files are used to construct key variables such as |BBPATH| 
> <https://www.yoctoproject.org/docs/2.4/bitbake-user-manual/bitbake-user-manual.html#var-BBPATH> 
> and |BBFILES| 
> <https://www.yoctoproject.org/docs/2.4/bitbake-user-manual/bitbake-user-manual.html#var-BBFILES>. 
> |BBPATH| is used to search for configuration and class files under the |conf| 
> and |classes| directories, respectively. |BBFILES| is used to locate both recipe 
> and recipe append files (|.bb| and |.bbappend|). If there is no |bblayers.conf| 
> file, it is assumed the user has set the |BBPATH| and |BBFILES| directly in the 
> environment.
> 
> In my opinion the last sentence should be: If there is no |layer.conf| file, it 
> is assumed the user has set the |BBPATH| and |BBFILES| directly in the environment.

I think no, layer.conf is a must for a layer, otherwise, you would get error
when parsing. The bblayers.conf is <build_dir>/conf/bblayers.conf, which is
used in build directory.

// Robert

> 
> Please check my statement as I could be wrong about it.
> 
> Kind regards!
> 
> Ivan Slaev
> 
> 
> 

