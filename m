Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TYPJB-0003b8-WD
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Nov 2012 23:50:18 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id qADMaF60026959
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 13 Nov 2012 14:36:15 -0800 (PST)
Received: from [172.25.32.40] (172.25.32.40) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Tue, 13 Nov 2012 14:36:15 -0800
Message-ID: <50A2CB5E.8030600@windriver.com>
Date: Tue, 13 Nov 2012 16:36:14 -0600
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:16.0) Gecko/20121011 Thunderbird/16.0.1
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
	<1352816623.24487.128.camel@ted>
	<CA+JN8xOF_iVQb30NVdrXEtqieh0E6m2-tSE2uG6UiG+f9C6qHw@mail.gmail.com>
	<1352820166.24487.136.camel@ted>
In-Reply-To: <1352820166.24487.136.camel@ted>
X-Enigmail-Version: 1.4.5
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] bitbake: Colorize knotty interactive console output
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
X-List-Received-Date: Tue, 13 Nov 2012 22:50:19 -0000
X-Groupsio-MsgNum: 2930
Content-Type: multipart/mixed; boundary="------------000803070303020603080609"

--------------000803070303020603080609
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 11/13/2012 09:22 AM, Richard Purdie wrote:
> On Tue, 2012-11-13 at 08:45 -0600, Seth Bollinger wrote:
>> I'm not sure how best to resolve this.  Would you like me to add some
>> code to try and detect background color?  This seems like it might be
>> more complex than it's worth...
>>
>> Or would it be better to have a selectable light background color
>> set?  If you think light background is more common (I dislike staring
>> at large blocks of white :)) it could default to the light color set.
> I have not looked into this and am not an expert on terminals and colour
> control of them. I don't know how we can solve this but the current
> situation where it prints white on white on my terminal is clearly
> unacceptable. This has to be a problem others have run into and solved
> before though...


If you are planning to colorize things, my recommendation would be to take the "middle ground" and use the transparency instead of using white which should work in general on any modern terminal.

Change the patch a bit like this:
+    color_enabled = False
+    BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(30,38)

    BASECOLOR, BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(29,38)

+
+    COLORS = {
+        DEBUG3  : CYAN,
+        DEBUG2  : CYAN,
+        DEBUG   : CYAN,
+        VERBOSE : BASECOLOR,
+        NOTE    : BASECOLOR,
+        PLAIN   : BASECOLOR,
+        WARNING : YELLOW,
+        ERROR   : RED,
+        CRITICAL: RED,
+    }


Most of the time terminals are either "dark" or "light", and default color is always set to -1 in the curses interface.  For example, the attached patch will allow the patch to work on my "lawngreen" default xterms as well as more typical defaults for gnome-terminal or rxvt.

Cheers,
Jason.

--------------000803070303020603080609
Content-Type: application/mbox; name="colors.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="colors.diff"

ZGlmZiAtLWdpdCBhL2xpYi9iYi9tc2cucHkgYi9saWIvYmIvbXNnLnB5CmluZGV4IDY4YjJhZDcu
LjIxMzkzMmQgMTAwNjQ0Ci0tLSBhL2xpYi9iYi9tc2cucHkKKysrIGIvbGliL2JiL21zZy5weQpA
QCAtNTYsMTUgKzU2LDE1IEBAIGNsYXNzIEJCTG9nRm9ybWF0dGVyKGxvZ2dpbmcuRm9ybWF0dGVy
KToKICAgICB9CiAKICAgICBjb2xvcl9lbmFibGVkID0gRmFsc2UKLSAgICBCTEFDSywgUkVELCBH
UkVFTiwgWUVMTE9XLCBCTFVFLCBNQUdFTlRBLCBDWUFOLCBXSElURSA9IHJhbmdlKDMwLDM4KQor
ICAgIEJBU0VDT0xPUiwgQkxBQ0ssIFJFRCwgR1JFRU4sIFlFTExPVywgQkxVRSwgTUFHRU5UQSwg
Q1lBTiwgV0hJVEUgPSByYW5nZSgyOSwzOCkKIAogICAgIENPTE9SUyA9IHsKICAgICAgICAgREVC
VUczICA6IENZQU4sCiAgICAgICAgIERFQlVHMiAgOiBDWUFOLAogICAgICAgICBERUJVRyAgIDog
Q1lBTiwKLSAgICAgICAgVkVSQk9TRSA6IFdISVRFLAotICAgICAgICBOT1RFICAgIDogV0hJVEUs
Ci0gICAgICAgIFBMQUlOICAgOiBXSElURSwKKyAgICAgICAgVkVSQk9TRSA6IEJBU0VDT0xPUiwK
KyAgICAgICAgTk9URSAgICA6IEJBU0VDT0xPUiwKKyAgICAgICAgUExBSU4gICA6IEJBU0VDT0xP
UiwKICAgICAgICAgV0FSTklORyA6IFlFTExPVywKICAgICAgICAgRVJST1IgICA6IFJFRCwKICAg
ICAgICAgQ1JJVElDQUw6IFJFRCwK

--------------000803070303020603080609--
