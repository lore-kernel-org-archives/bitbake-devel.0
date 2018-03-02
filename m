Return-Path: <pn@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail.openembedded.org (Postfix) with ESMTP id 22CB071A84
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Mar 2018 12:58:37 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3zt8W24R2yz1qtfD;
	Fri,  2 Mar 2018 13:58:38 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 3zt8W247JPz1qqkM;
	Fri,  2 Mar 2018 13:58:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
	port 10024)
	with ESMTP id uZloj8BaQe6N; Fri,  2 Mar 2018 13:58:35 +0100 (CET)
X-Auth-Info: CM2RTXEeQ/njLkJIq6RjHbVyq0+8RFsoX9l0BGyNB7E=
Received: from antares.denx.de (unknown [62.91.23.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri,  2 Mar 2018 13:58:35 +0100 (CET)
To: "Maxin B. John" <maxin.john@intel.com>
References: <1c9ddeef-cae3-20b7-964b-768f999c7803@denx.de>
	<20180302122913.GA15235@mbabyjoh-desk.ger.corp.intel.com>
From: Parthiban Nallathambi <pn@denx.de>
Message-ID: <d5285955-4e4c-ea92-015f-ecd17b8a63ea@denx.de>
Date: Fri, 2 Mar 2018 13:58:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302122913.GA15235@mbabyjoh-desk.ger.corp.intel.com>
Cc: yocto@yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: Yocto: Add custom user to custom group in bitbake recipe
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
X-List-Received-Date: Fri, 02 Mar 2018 12:58:38 -0000
X-Groupsio-MsgNum: 9226
Content-Type: multipart/mixed; boundary="------------42496DEE4699013153D16393"
Content-Language: en-US

--------------42496DEE4699013153D16393
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

space.bb --> chromium recipe in 
https://github.com/OSSystems/meta-browser/tree/master/recipes-browser/chromium

app.bb --> http-server.bb attached

I have created a group "www" in http-server_0.10.0.bb and trying to add 
"chromium" user to this group in chromium-x11_%.bbappend.

But the useradd command is failed: group 'www' does not exit.


On 03/02/2018 01:29 PM, Maxin B. John wrote:
> Hi Parthiban,
> 
> On Fri, Mar 02, 2018 at 12:29:25PM +0100, Parthiban Nallathambi wrote:
>> Hello All,
>>
>> I have created a custom group e.g "grp1" in my application recipe say
>> "app.bb".
>>
>> GROUPADD_PARAM_${PN} = "grp1"
>>
>> I am trying add my custom user e.g: "user1" to this group "grp1" in
>> "space.bb".
>>
>> USERADD_PARAM_${PN} = "-d ${localstatedir}/lib/space/ -s /bin/false -G grp1
>> -U user1"
>>
>> The useradd command failed saying the "useradd: group 'grp1' does not
>> exist". I have also tried adding DEPENDS_${PN} = "app" in space.bb, but it
>> doesn't help.
>>
>> How can I add my custom user to my custom group in bitbake recipe?
> 
> Please share your sample recipes here. It will be helpful to debug the problem.
> 
>> Question in Stackoverflow: https://stackoverflow.com/questions/49068076/yocto-add-custom-user-to-custom-group
>>
>> -- 
>> Thanks,
>> Parthiban Nallathambi
> 
> Best Regards,
> Maxin
> 

-- 
Thanks,
Parthiban Nallathambi

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--------------42496DEE4699013153D16393
Content-Type: text/plain; charset=UTF-8;
 name="chromium-x11_%.bbapend"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="chromium-x11_%.bbapend"

aW5oZXJpdCBzeXN0ZW1kCmluaGVyaXQgdXNlcmFkZAoKIyBza2lwIHJ1bnRpbWUgZGVwZW5kZW5j
eSBvbiBiYXNoCiMgc2luY2Ugd2UgZG9uJ3QgdXNlIHRoZSB3cmFwcGVyIHNjcmlwdApSREVQRU5E
U18ke1BOfV9yZW1vdmUgPSAiYmFzaCIKCkZJTEVTRVhUUkFQQVRIU19hcHBlbmQgOj0gIiR7VEhJ
U0RJUn0vZmlsZXM6IgoKU1JDX1VSSSArPSAiIFwKICAgICBmaWxlOi8vY2hyb21pdW0tc3RhcnQg
XAogICAgIGZpbGU6Ly9jaHJvbWl1bS5zZXJ2aWNlIFwKICAgICBmaWxlOi8vY2hyb21pdW0tdHR5
LnJ1bGVzIFwKICAgICAiCgpkb19pbnN0YWxsX2FwcGVuZCgpIHsKCiAgICBpbnN0YWxsIC1kICR7
RH0ke3N5c3RlbWRfdW5pdGRpcn0vc3lzdGVtCiAgICBpbnN0YWxsIC1tIDc1NSAke1dPUktESVJ9
L2Nocm9taXVtLXN0YXJ0ICAke0R9JHtiaW5kaXJ9LwogICAgaW5zdGFsbCAtbSA2NDQgJHtXT1JL
RElSfS9jaHJvbWl1bS5zZXJ2aWNlICR7RH0ke3N5c3RlbWRfdW5pdGRpcn0vc3lzdGVtCgogICAg
aW5zdGFsbCAtZCAke0R9JHtzeXNjb25mZGlyfS91ZGV2L3J1bGVzLmQKICAgIGluc3RhbGwgLW0g
NjQ0ICR7V09SS0RJUn0vY2hyb21pdW0tdHR5LnJ1bGVzICR7RH0ke3N5c2NvbmZkaXJ9L3VkZXYv
cnVsZXMuZAoKICAgIHJtICR7RH0ke2xpYmRpcn0vY2hyb21pdW0vY2hyb21pdW0td3JhcHBlcgog
ICAgcm0gJHtEfSR7YmluZGlyfS9jaHJvbWl1bQogICAgbG4gLXMgJHtsaWJkaXJ9L2Nocm9taXVt
L2Nocm9taXVtLWJpbiAke0R9JHtiaW5kaXJ9L2Nocm9taXVtCn0KClNZU1RFTURfU0VSVklDRV8k
e1BOfSA9ICJjaHJvbWl1bS5zZXJ2aWNlIgpGSUxFU18ke1BOfSArPSAiICR7YmluZGlyfS9jaHJv
bWl1bS1zdGFydCAke3N5c2NvbmZkaXJ9L3VkZXYvcnVsZXMuZC9jaHJvbWl1bS10dHkucnVsZXMi
CgpVU0VSQUREX1BBQ0tBR0VTID0gIiR7UE59IgpVU0VSQUREX1BBUkFNXyR7UE59ID0gIi1kICR7
bG9jYWxzdGF0ZWRpcn0vbGliL2Nocm9taXVtIC1zIC9iaW4vZmFsc2UgLUcgdHR5LHZpZGVvLGlu
cHV0LHd3dyx3d3ctZGF0YSAtVSBjaHJvbWl1bSIK

--------------42496DEE4699013153D16393
Content-Type: text/plain; charset=UTF-8;
 name="http-server_0.10.0.bb"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="http-server_0.10.0.bb"

U1VNTUFSWSA9ICJodHRwLXNlcnZlcjogYSBjb21tYW5kLWxpbmUgaHR0cCBzZXJ2ZXIiCkRFU0NS
SVBUSU9OID0gImh0dHAtc2VydmVyIGlzIGEgc2ltcGxlLCB6ZXJvLWNvbmZpZ3VyYXRpb24gY29t
bWFuZC1saW5lIFwKaHR0cCBzZXJ2ZXIuIEl0IGlzIHBvd2VyZnVsIGVub3VnaCBmb3IgcHJvZHVj
dGlvbiB1c2FnZSwgYnV0IGl0J3Mgc2ltcGxlIFwKYW5kIGhhY2thYmxlIGVub3VnaCB0byBiZSB1
c2VkIGZvciB0ZXN0aW5nLCBsb2NhbCBkZXZlbG9wbWVudCwgYW5kIGxlYXJuaW5nLlwKIgpMSUNF
TlNFID0gIk1JVCIKTElDX0ZJTEVTX0NIS1NVTSA9ICJmaWxlOi8vTElDRU5TRTttZDU9ODgwNWI2
ZjhiOGM0ZjZjZWZmNTIwZjRjM2FhYTgwOTQiCgpTUkNfVVJJID0gIm5wbTovL3JlZ2lzdHJ5Lm5w
bWpzLm9yZztuYW1lPWh0dHAtc2VydmVyO3ZlcnNpb249JHtQVn0gXAoJZmlsZTovL2h0dHAtc2Vy
dmVyLnNlcnZpY2UgXAoJZmlsZTovL3NzY19nZW4uc2ggXAoJIgppbmhlcml0IG5wbQojIE11c3Qg
YmUgc2V0IGFmdGVyIGluaGVyaXQgbnBtIHNpbmNlIHRoYXQgaXRzZWxmIHNldHMgUwpTID0gIiR7
V09SS0RJUn0vbnBtcGtnIgpERVBFTkRTXyR7UE59ID0gIm5vZGVqcy1ucG0iClJERVBFTkRTXyR7
UE59LWVjc3RhdGljID0gImJhc2giCgpMSUNFTlNFXyR7UE59ID0gIk1JVCIKCmluaGVyaXQgc3lz
dGVtZAppbmhlcml0IHVzZXJhZGQKZG9faW5zdGFsbF9hcHBlbmQoKSB7CgogICAgaW5zdGFsbCAt
ZCAke0R9JHtzeXN0ZW1kX3VuaXRkaXJ9L3N5c3RlbQogICAgaW5zdGFsbCAtbSA2NDQgJHtXT1JL
RElSfS9odHRwLXNlcnZlci5zZXJ2aWNlICR7RH0ke3N5c3RlbWRfdW5pdGRpcn0vc3lzdGVtCiAg
ICBpbnN0YWxsIC1tIDc1NSAke1dPUktESVJ9L3NzY19nZW4uc2ggJHtEfSR7YmluZGlyfQp9CgpT
WVNURU1EX1NFUlZJQ0VfJHtQTn0gPSAiaHR0cC1zZXJ2ZXIuc2VydmljZSIKVVNFUkFERF9QQUNL
QUdFUyA9ICIke1BOfSIKR1JPVVBBRERfUEFSQU1fJHtQTn0gPSAid3d3IgpVU0VSQUREX1BBUkFN
XyR7UE59ID0gIi1kICR7bG9jYWxzdGF0ZWRpcn0vbGliL2Nocm9taXVtIC1zIC9iaW4vZmFsc2Ug
LUcgd3d3LWRhdGEgLVUgd3d3Igo=

--------------42496DEE4699013153D16393--
