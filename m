Received: from m13-38.163.com ([220.181.13.38])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <huanmateme@163.com>) id 1TlvxL-0007jB-78
	for bitbake-devel@lists.openembedded.org;
	Fri, 21 Dec 2012 07:19:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Received:Date:From:To:Subject:Content-Type:
	MIME-Version:Message-ID; bh=1OgEGNxQja7n7XaVr734KVTV15CPDw7Gmk6r
	xs/VIC0=; b=cmkIeKPYrOpYoySWL8pu3sa4ezLugcspBncN+gfYUFlHTCwpdoZU
	aUxkvxYlKgmKE8zmdZSllT+MzAzbdAFdyiQTQJOZM2PxiqCpTsw6p8dbg0G0K4pW
	1Ym93FqCBqJq9Swh/K1Woq3ZTHsHMyuAQYN89E1k/AK2wEQM+AM3MBk=
Received: from huanmateme$163.com ( [61.148.56.138] ) by
	ajax-webmail-wmsvr38 (Coremail) ; Fri, 21 Dec 2012 13:49:41 +0800 (CST)
X-Originating-IP: [61.148.56.138]
Date: Fri, 21 Dec 2012 13:49:41 +0800 (CST)
From: Biao <huanmateme@163.com>
To: bitbake-dev <bitbake-devel@lists.openembedded.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
	20121210(21001.5125.5051) Copyright (c) 2002-2012 www.mailtech.cn
	163com
MIME-Version: 1.0
Message-ID: <45483db.6a2c.13bbc028c57.Coremail.huanmateme@163.com>
X-CM-TRANSID: JsGowGD5nkB2+NNQg40SAA--.11625W
X-CM-SenderInfo: xkxd0z5dwhzvi6rwjhhfrp/xtbBiBOMgE9o6j6rYQAAsu
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Subject: Where does the python print goes?
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
X-List-Received-Date: Fri, 21 Dec 2012 06:19:41 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_100674_339454317.1356068981847"

------=_Part_100674_339454317.1356068981847
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit

Hi All,


I have a task in a dum.bb file, after running the task with -vDDD, i can not find where the "I am the python output" goes, it is not in the terminal, not in the log file. Where does the sys.__stdout__.write output to?


/*----code snap begins---*/
python do_dm2 () {
        import sys
        sys.__stdout__.write("I am the python output\n")
}
addtask dm2
/*----code snap ends---*/


Best Regards,
Biao

------=_Part_100674_339454317.1356068981847
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: 7bit

<div style="line-height:1.7;color:#000000;font-size:14px;font-family:arial"><div>Hi All,</div><div><br></div><div>I have a task in a dum.bb file, after running the task with -vDDD, i can not find where the "I am the python output" goes, it is not in the terminal, not in the log file. Where does the sys.__stdout__.write output to?</div><div><br></div><div>/*----code snap begins---*/</div><div>python do_dm2 () {</div><div>&nbsp; &nbsp; &nbsp; &nbsp; import sys</div><div>&nbsp; &nbsp; &nbsp; &nbsp; sys.__stdout__.write("I am the python output\n")</div><div>}</div><div>addtask dm2</div><div>/*----code snap ends---*/</div><div><br></div><div>Best Regards,</div><div>Biao</div></div>

------=_Part_100674_339454317.1356068981847--
