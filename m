Return-Path: <Joel.Esponde@Honeywell.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
	(mail-bl2on0137.outbound.protection.outlook.com [65.55.169.137])
	by mail.openembedded.org (Postfix) with ESMTP id A38C9607A4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Apr 2016 12:53:40 +0000 (UTC)
Received: from DM2PR07CA0047.namprd07.prod.outlook.com (10.141.52.175) by
	BN3PR0701MB1204.namprd07.prod.outlook.com (10.160.114.28) with
	Microsoft SMTP
	Server (TLS) id 15.1.466.19; Fri, 22 Apr 2016 12:53:40 +0000
Received: from BY2FFO11FD006.protection.gbl (2a01:111:f400:7c0c::109) by
	DM2PR07CA0047.outlook.office365.com (2a01:111:e400:2414::47) with
	Microsoft SMTP Server (TLS) id 15.1.466.19 via Frontend Transport;
	Fri, 22 Apr 2016 12:53:40 +0000
Authentication-Results: spf=neutral (sender IP is 199.61.26.155)
	smtp.mailfrom=Honeywell.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=none action=none
	header.from=Honeywell.com;
Received-SPF: Neutral (protection.outlook.com: 199.61.26.155 is neither
	permitted nor denied by domain of Honeywell.com)
Received: from DE08W1027.honeywell.com (199.61.26.155) by
	BY2FFO11FD006.mail.protection.outlook.com (10.1.14.127) with Microsoft
	SMTP Server (TLS) id 15.1.472.8 via Frontend Transport;
	Fri, 22 Apr 2016 12:53:39 +0000
Received: from de08ex5005.global.ds.honeywell.com (10.216.34.43) by
	DE08W1027.honeywell.com (10.221.248.38) with Microsoft SMTP Server id
	14.3.266.1; Fri, 22 Apr 2016 05:53:11 -0700
Received: from DE08W1305.global.ds.honeywell.com ([169.254.1.251]) by
	de08ex5005.global.ds.honeywell.com ([10.216.14.78]) with mapi id
	14.03.0266.001; Fri, 22 Apr 2016 08:53:13 -0400
From: "Esponde, Joel" <Joel.Esponde@Honeywell.com>
To: "Esponde, Joel" <Joel.Esponde@Honeywell.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Fetcher issue: Error communicating with
	gnome-keyring-daemon
Thread-Index: AdGceHU9FcWlpVhrTX+l8V+kRxiwFgAHPDNA
Date: Fri, 22 Apr 2016 12:53:13 +0000
Message-ID: <F6CD090A69E64C4289DC608E1C5D2024253E0D02@DE08W1305.global.ds.honeywell.com>
References: <F6CD090A69E64C4289DC608E1C5D2024253E0CBB@DE08W1305.global.ds.honeywell.com>
In-Reply-To: <F6CD090A69E64C4289DC608E1C5D2024253E0CBB@DE08W1305.global.ds.honeywell.com>
Accept-Language: fr-FR, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [158.138.38.18]
MIME-Version: 1.0
X-CFilter-Loop: Forwarded
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.61.26.155; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10019020)(6009001)(2980300002)(189002)(76104003)(199003)(2906002)(6116002)(102836003)(790700001)(19580405001)(19580395003)(586003)(3846002)(85806002)(87936001)(84326002)(6806005)(19300405004)(1220700001)(1096002)(81166005)(86362001)(230783001)(5003600100002)(55846006)(2910100002)(105586002)(450100001)(106466001)(11100500001)(551544002)(5004730100002)(16236675004)(33656002)(5008740100001)(66066001)(16796002)(2920100001)(19625215002)(189998001)(5001770100001)(77096005)(2950100001)(2501003)(512934002)(92566002)(50986999)(54356999)(2940100001)(2900100001)(76176999)(15975445007)(107886002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN3PR0701MB1204;
	H:DE08W1027.honeywell.com; FPR:; SPF:Neutral; MLV:sfv; MX:1; A:1;
	LANG:en; 
X-Microsoft-Exchange-Diagnostics: 1; BY2FFO11FD006;
	1:C9G9EzYF71mCDTrIhfLOo8P7zS9ad8hRmgOXWOzHStcnaVmw0SmCunFFn5Vs3DldSziyAzMzPd4OaXQVNrwRQTyqhT2VG18B3KwfPlSn3hPm5a2zncO1QHI1GkDj4iaUO3yEF3uLZNqCk7EFYHvDYT233W5dXw+zOnYaePIkFMqy0kz3SQnaMR73LauV0hOAFvWBdYBZ2cbXjvBma+riFz54rXW8fV2Ooq69MjDM/pqtgF92MkNG5x1e/6DHAq2V3Fy6j6g71VQfWulkf0xOcgQzkKPjVkqJLtAI4lhQ8C2Pyvmonuo+Wm4z3EpAoXh8oc5zvfg+VhQFU3180tYw5/aBheHtN2356YUgR3+bUXOmzIn9SWgfePBdEkdJUJIViDSP+zFqrmDtUWLK9U1aPXd5O2wWIcQf+5RntnEV5zyb4mZlWLTR5qtsGsqMcvLBupWyaYm+HbWoaHEMgOCtViz6B7W3ahxS/rraukU2DR7K7lmZxx17ikvOY+MmnSqo+Por/jcSkB1bz1YWfphT/8gzCz9NHwg17nffpezKAco=
X-MS-Office365-Filtering-Correlation-Id: cb58e703-f147-4d15-433a-08d36aad20c8
X-Microsoft-Exchange-Diagnostics: 1; BN3PR0701MB1204;
	2:5UiWKBwsEKNGAJMTS41cVXqe7YlUTsrWCumVyVz9AwxlaDPUPbCFXHsZPA7FFlkFvMR35pz1X9az7No6fGWp+8x865Q3/MCRAWuVUA+bsWM0q42HAzI0gC599/xW370faQrLu/VVO8WJdQte1Rmnsg+1knKI+lf7ilju8UYVgdV22sf+g189JE06jVXsdR2h;
	3:1SYUNATNW/LSl4UNTFK8xwRj8dU27IAoL1FJfSunmpFuEawG6RB6hFCRyjjlX2kBQh+SoBOfD/pdjPc3iU0vQwUShMMe5FEonzoUdHQFNwFldcDzljOhVVUAmU6g32p0Ih/cdU8bi9/cr9Wi5zLFRAkE2Ag8ni5IUSwnYMZTIRI093ZTQKogGCmS2E6M6pu98EdwYwBSWficyaKcxIUpqf8qoC+Iidp1lodoqaXM4hw=;
	25:HEluhiREg8vZO2WbRHn4aLdRG5j5/7a/rnoSa352OZ+9FXEW7PBkMyQSpMtQ1Yi1BwhVrVWxQKZ/sYxi4gnrnI6LLGNKYhOXfWHP64r3f5KuIdSJa9dLidGsQTyiL+q77KuJCEpYpsTlHZydcCdidJF6ux0Y/FXnGvqeuxLW7k8jybHtfKSQNc6YGWao+Z8LdLUmfxcDlD+37vm9FDRiF0CF1ce89rGmeb10gtcIv9CM8VW4mHlBvlJSO5J2dEpjqcKV7RpCG6FGVIdCoEUtTYafJt7P3JOZPuEP6dvf31hQsWN52oMI7aAxnM8EfkMyFQ1kDz6jHei+qmXtfDbDEA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1204;
X-Microsoft-Exchange-Diagnostics: 1; BN3PR0701MB1204;
	20:Gssp69MM7mFBH9JR9f5L5t0Wj0gu9w5et3Q0pTMVtidrCG+rgB1Y6O7dmEWk37Es31I5cSeLZ4/882GMjsQC7RUybuuOhcm+QhwIU5VD/lEskPhETn8g37YOdpgvEYe2jp8X/asCNg+HwqKjcciD69O4jgQS3rd/QoHZihsVBq/wNszfmamIS3Wd/RflVQQ7Q6vjBCJxPzBVFsOG/7NHm9NvOvRtb3OOwOAZBwQrUReVerYhGOECF7ribVcONUTsE7sQIuuXKLRGoqkNsl1vS6MKZX8488ZL70tp5w96cQYYudW86V7VXp/veMcIsFK3Ots1ooMLIAK3BmRHnVjFvQijUHDmvvDC6aGGO8yo/6mzVRNUqUUntjllYpTOpmp3mvU3fVwdcWYPG3IfeA1cyUYPwKayapr4j5oVtkrqcAniiay48RRBfbRrH6h07bkR/rgy+gSHaowvtLpLNo/ynRgIbWvb8+Rz+0GO4ePLjmdTub0JFRXke/VK8ErB89GT
X-Microsoft-Antispam-PRVS: <BN3PR0701MB1204BE766A27858D81ADB187966F0@BN3PR0701MB1204.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(9101521026)(601004)(2401047)(8121501046)(5005006)(13017025)(13015025)(13024025)(13018025)(13023025)(3002001)(10201501046)(6055026);
	SRVR:BN3PR0701MB1204; BCL:0; PCL:0; RULEID:;
	SRVR:BN3PR0701MB1204; 
X-Microsoft-Exchange-Diagnostics: 1; BN3PR0701MB1204;
	4:I2lYxXN9h16mFT2nKnMJS6EpoRyaHz2TFAQP/Lf5TiC82X5PBePOB3aH3IGZ4tJvS1jpFUZHHIsMyuqX+nuWwEjiOREVFgzf2MTjggvFCJ5aZ2u1j0I4IGCvzEWL+qle88kFInTj0M7JzSwTZlQAOmDTMih4HZUqrjVJXZBKsu5SwZh9k+1/pjmeCUducvUYZUksS44DISv0fCcWbytl1jWVY3Y3n3y9HULg2hskrDSeoNpD9UHkDOTd2wm1h0btb5z2hv9SuWP5meHHVJUfM2WIfu1tYGWIdJG+u8oYqo4i2wVwWONpJFRvl6XrJi5WSwBiz0Ss/4kfSNNC/93WLamXjtWR0EQa+CTunQ30ANw6QyufgI+Qut1U0fzvOKGshhwmdOzqjzSsPjfkDL99SMxUm4Jc0aJQ1WxX116t4Uhswh8YfkycpMC/veyYzkbhYTwI0orylrNODibmAE8RTznrEVRo12kKrT+CC6h7lUq3OEodMfh7V+nwPONNuo6U
X-Forefront-PRVS: 0920602B08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; BN3PR0701MB1204;
	23:UZuSPMJnOHfcVTcCxpaFvMikohurDaxwRxJgCW6?=
	=?us-ascii?Q?2HFo1BUJHvX+T03zCwI9kPl9aIdFWCTSN8/ctSKkcf8AJIT2xfjZpxwOVZw1?=
	=?us-ascii?Q?cB9N8D0omP8OASE4L7H64+J7bcfCrmvtfbHEYFHJ51hLpnt2pmQrru4XMSkR?=
	=?us-ascii?Q?CM1j9XE26LOWum2blpU0v9WG9hMSNUfElILI4SYlvPQzMGIBbE0eC3RfSigs?=
	=?us-ascii?Q?lMF9KddR3HTSfaY0U1RciDEROPgnPEp+KIKijzgQgM2IbTCMtNhGNd0SnFcf?=
	=?us-ascii?Q?JROJW0mdMS4BlQPDcCBpqebOtpfg3yvAyY2FjVe+cQFLTgCvCqf3OOnbu6ZF?=
	=?us-ascii?Q?BhnMAbBp3v2cGIrsnHSyr9TIopbqvzSuBYhe2sVZJJGw3w7LPq8re2rFjhV7?=
	=?us-ascii?Q?1/+btyIoDZPrrce6JLjnjF14OdP1GhmpdluKFFPboUpC8C90ZU0yrZlTgmlg?=
	=?us-ascii?Q?+HLKM20q+7puhF2h0q89WXO/6a+6x/IaBce29TVVsrEObzydyhJT6Ez2vFiu?=
	=?us-ascii?Q?RMgLW8m6L0ZHy0Vp+OeWZq2hk8Hv90mW9h5M5oua6tJvmeqhjd9RNdVTKdzh?=
	=?us-ascii?Q?P/wxUVfc6vhqy05fBzlDH0Ia+OM6+Cw3j/02YNl29WNxpEOBwkQdXwAl0o9q?=
	=?us-ascii?Q?tTpqwiJdW+U3ons7qRNRoG7afM7IfK6DGra/Ahp8pBdg0D1TbbXc2r02fIoA?=
	=?us-ascii?Q?JGsYeXYg/P/ZDDHsVHGnJDor937vSKmlentJbH1/tJKevubCkPwhquiN16HK?=
	=?us-ascii?Q?TknW5fcDcKwU9DNCpmsmzX9OJnzJtsK+eY6XmKFfuiWK00yW4v16YQLLbrBQ?=
	=?us-ascii?Q?hZVdOwruvJ3O0ym2SAI1VGIdlh2d7S8hYC4eIpuA6S77RaoUFQcE/d3h4JGH?=
	=?us-ascii?Q?1pOx610ieMIdBNZiQeNvPTXTzd4cARf4UwOYlxHGUevRx59Npm4CPrpsFXld?=
	=?us-ascii?Q?GTJHQDYC6e8kIWGVVaV//wxmw4+0XOH3KrBV4+7SB9bRZ4QTw41OXRJ4sT8P?=
	=?us-ascii?Q?H2MoClYFTrK4RozfExOcrFdPUwed5t07Pp+xqPOhki+WV47GK+53G1nHOzLy?=
	=?us-ascii?Q?hEYWEXVXHo0/f7YiK++Cb25xmUW266B4h1xn536mA/pb9ZODWI3lCXN8oDjw?=
	=?us-ascii?Q?OkSceocnzw7eyWpVB294nqFFVbmrv6kiJW3nP6kTqEVxjRzlqdMpb3eL6cZD?=
	=?us-ascii?Q?Wan74OJkl129Chftbu1jF/H3BD152DLXydb+ItxvnRta8ii9u8cvxjM3wq5Q?=
	=?us-ascii?Q?p5YxjF7VWvJrfay8DLb2v5OMK1A3jmeZaE/49fL9tFIRVm/8/JPq/lKqWZKK?=
	=?us-ascii?Q?Zsmz3NuAkvaRrqAAUHHNUEu3Tiq5vWHrN7pDLCDQqiLQgDhfI8hhkkoRTsDI?=
	=?us-ascii?Q?31xgZRzeGzDUg+gMvuRfFA+vSbUMv25mP3HejTSWn2lS3f/5c?=
X-Microsoft-Exchange-Diagnostics: 1; BN3PR0701MB1204;
	5:k8ECcTD/5c0+u32O7rNRBXIKf/XZVdLMLSxiw77qFH4HdiPJnh7/ST2px1aKIqHPPp9U2YkS+I5uq8/ly7Au8ZW5p1EseJRlvZTvzlNsKcWdGtqYT/Bd7r+7W8tm/miXBIaRBwro2nNysfofbs/a5YtuR0humlGKc0o09cM8h5GGkaRIZFqkf2BmJz/nQhpd;
	24:/9/TFNOrOr8c6mnEJGBZYQDARpcvNCOABstuoUSQW/9VhK2QKYnepod8HTYmJ2qumH2hPTI+efXlL461UVSRc50ksOYt+eBkqZei2iM3Q2s=;
	7:+hucPw9J0nra5TbujDi+oOSuKBAA6cg9zJNRA0TypUZbkMpis/1x7i0xOY/2hw6+v5bpmGpMUIHu+OdYaoCrnTJW8JVPPLTViANDrlek4jhKaGVtjzF0bpMwlIAjg+5rZa3kpOc7AgkZ/9w7OfYvd12CYHsr5YgfrZ/+UelrLJO8GjplAi5S3pnm4g+11zOIHqYbWav/DVudJpKTG6Tt+D0zMDt2Uo4peFC1vZVQCUk=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Honeywell.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2016 12:53:39.7665 (UTC)
X-MS-Exchange-CrossTenant-Id: 96ece526-9c7d-48b0-8daf-8b93c90a5d18
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=96ece526-9c7d-48b0-8daf-8b93c90a5d18;
	Ip=[199.61.26.155]; Helo=[DE08W1027.honeywell.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1204
Subject: Re: Fetcher issue: Error communicating with gnome-keyring-daemon
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
X-List-Received-Date: Fri, 22 Apr 2016 12:53:42 -0000
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_F6CD090A69E64C4289DC608E1C5D2024253E0D02DE08W1305global_"

--_000_F6CD090A69E64C4289DC608E1C5D2024253E0D02DE08W1305global_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I found another way to give access to Gnome Keyring by just adding this to =
the recipe:

# We needs to export DBUS_SESSION_BUS_ADDRESS in git fetcher environment to=
 let
# git be able to access Gnome Keyring through D-Bus
def getDSBA(d):
    origenv =3D d.getVar("BB_ORIGENV", False)
    dsba =3D origenv.getVar("DBUS_SESSION_BUS_ADDRESS", False)
    #print("dsba: " + dsba)
    return dsba
FETCHCMD_git =3D "export DBUS_SESSION_BUS_ADDRESS=3D${@getDSBA(d)}; git -c =
core.fsyncobjectfiles=3D0"

Jo=EBl Esponde
Honeywell | Sensing and Productivity Solutions

De : bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bou=
nces@lists.openembedded.org] De la part de Esponde, Joel
Envoy=E9 : vendredi 22 avril 2016 11:38
=C0 : bitbake-devel@lists.openembedded.org
Objet : [bitbake-devel] Fetcher issue: Error communicating with gnome-keyri=
ng-daemon

Hi,

When bitbake tries to fetch code from a git repository that needs authentic=
ation whose credentials are stored in Gnome Keyring, it fails and produces =
this error:

    ** (process:53010): CRITICAL **: Error communicating with gnome-keyring=
-daemon
    fatal: could not read Username for 'https://git.someserver.com': No suc=
h device or address


git-credential-gnomekeyring is the helper used by git to store credentials =
in Gnome Keyring.
git-credential-gnomekeyring uses D-Bus to communicate with Gnome Keyring wh=
en X or Gnome environment is not accessible (for example, through SSH).
Therefore, *.bashrc* is modified like this during *git-credential-gnomekeyr=
ing* installation:

    # git-credential-gnome-keyring:
    # If you are connected to your workstation via SSH, you'll need to set =
up D-Bus,
    # or else you'll get Error communicating with gnome-keyring-daemon.
    # The solution is to add the following to your .bashrc or .zshrc file:
    if [[ -z $DBUS_SESSION_BUS_ADDRESS ]]; then
        if [[ -f ~/.dbus/session-bus/$(dbus-uuidgen --get)-0 ]]; then
            source ~/.dbus/session-bus/$(dbus-uuidgen --get)-0
            export DBUS_SESSION_BUS_ADDRESS
        fi
    fi

So one way to allow bitbake's fetcher access Gnome Keyring is to avoid DBUS=
_SESSION_BUS_ADDRESS variable being removed from bitbake's fetcher environm=
ent.

This can be achieved in those two steps:


-          First, fetcher's code needs to stop filtering DBUS_SESSION_BUS_A=
DDRESS, here is the fix:

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index b004dae..392e307 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -784,7 +784,8 @@ def runfetchcmd(cmd, d, quiet =3D False, cleanup =3D []=
):
                   'ALL_PROXY', 'all_proxy',
                   'GIT_PROXY_COMMAND',
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
-                  'SOCKS5_USER', 'SOCKS5_PASSWD']
+                  'SOCKS5_USER', 'SOCKS5_PASSWD',
+                  'DBUS_SESSION_BUS_ADDRESS']

     for var in exportvars:
         val =3D d.getVar(var, True)


-          Secondly, bitbake needs also to stop filtering DBUS_SESSION_BUS_=
ADDRESS thanks to its environment set like this:

$ export BB_ENV_EXTRAWHITE=3D"DBUS_SESSION_BUS_ADDRESS"

What do you think about this fix?

My main concern about this solution is that any user that would store his g=
it's credentials in Gnome Keyring would have to set BB_ENV_EXTRAWHITE befor=
e being able to use bitbake... It does not look like very handy...

Jo=EBl Esponde
Honeywell | Sensing and Productivity Solutions


--_000_F6CD090A69E64C4289DC608E1C5D2024253E0D02DE08W1305global_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#400000;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#400000;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
span.sc11
	{mso-style-name:sc11;
	font-family:"Courier New";
	color:black;}
span.sc0
	{mso-style-name:sc0;
	font-family:"Courier New";
	color:black;}
span.sc51
	{mso-style-name:sc51;
	font-family:"Courier New";
	color:blue;
	font-weight:bold;}
span.sc91
	{mso-style-name:sc91;
	font-family:"Courier New";
	color:fuchsia;}
span.sc101
	{mso-style-name:sc101;
	font-family:"Courier New";
	color:navy;
	font-weight:bold;}
span.sc31
	{mso-style-name:sc31;
	font-family:"Courier New";
	color:gray;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:420834140;
	mso-list-type:hybrid;
	mso-list-template-ids:1730204854 -1564840762 67895299 67895301 67895297 67=
895299 67895301 67895297 67895299 67895301;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"FR" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">I found=
 another way to give access to Gnome Keyring by just adding this to the rec=
ipe:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-US" styl=
e=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:gray;mso-fa=
reast-language:FR"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:35.4pt;background:white"><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot=
;;color:green;mso-fareast-language:FR"># We needs to export DBUS_SESSION_BU=
S_ADDRESS in git fetcher environment to let
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:35.4pt;background:white"><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot=
;;color:green;mso-fareast-language:FR"># git be able to access Gnome Keyrin=
g through D-Bus<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:35.4pt;background:white"><b><sp=
an lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&q=
uot;;color:blue;mso-fareast-language:FR">def</span></b><span lang=3D"EN-US"=
 style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:black;=
mso-fareast-language:FR">
</span><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Cou=
rier New&quot;;color:fuchsia;mso-fareast-language:FR">getDSBA</span><b><spa=
n lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&qu=
ot;;color:navy;mso-fareast-language:FR">(</span></b><span lang=3D"EN-US" st=
yle=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:black;mso=
-fareast-language:FR">d</span><b><span lang=3D"EN-US" style=3D"font-size:10=
.0pt;font-family:&quot;Courier New&quot;;color:navy;mso-fareast-language:FR=
">):</span></b><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&=
quot;Courier New&quot;;color:black;mso-fareast-language:FR"><o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"margin-left:35.4pt;background:white"><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot=
;;color:black;mso-fareast-language:FR">&nbsp;&nbsp;&nbsp; origenv
</span><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;=
Courier New&quot;;color:navy;mso-fareast-language:FR">=3D</span></b><span l=
ang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;=
;color:black;mso-fareast-language:FR"> d</span><b><span lang=3D"EN-US" styl=
e=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:navy;mso-fa=
reast-language:FR">.</span></b><span lang=3D"EN-US" style=3D"font-size:10.0=
pt;font-family:&quot;Courier New&quot;;color:black;mso-fareast-language:FR"=
>getVar</span><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family=
:&quot;Courier New&quot;;color:navy;mso-fareast-language:FR">(</span></b><s=
pan lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&=
quot;;color:gray;mso-fareast-language:FR">&quot;BB_ORIGENV&quot;</span><b><=
span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New=
&quot;;color:navy;mso-fareast-language:FR">,</span></b><span lang=3D"EN-US"=
 style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:black;=
mso-fareast-language:FR">
</span><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;=
Courier New&quot;;color:blue;mso-fareast-language:FR">False</span></b><b><s=
pan lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&=
quot;;color:navy;mso-fareast-language:FR">)</span></b><span lang=3D"EN-US" =
style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:black;m=
so-fareast-language:FR"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:35.4pt;background:white"><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot=
;;color:black;mso-fareast-language:FR">&nbsp;&nbsp;&nbsp; dsba
</span><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;=
Courier New&quot;;color:navy;mso-fareast-language:FR">=3D</span></b><span l=
ang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;=
;color:black;mso-fareast-language:FR"> origenv</span><b><span lang=3D"EN-US=
" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:navy;=
mso-fareast-language:FR">.</span></b><span lang=3D"EN-US" style=3D"font-siz=
e:10.0pt;font-family:&quot;Courier New&quot;;color:black;mso-fareast-langua=
ge:FR">getVar</span><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;;color:navy;mso-fareast-language:FR">(</span>=
</b><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courie=
r New&quot;;color:gray;mso-fareast-language:FR">&quot;DBUS_SESSION_BUS_ADDR=
ESS&quot;</span><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-fami=
ly:&quot;Courier New&quot;;color:navy;mso-fareast-language:FR">,</span></b>=
<span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier Ne=
w&quot;;color:black;mso-fareast-language:FR">
</span><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;=
Courier New&quot;;color:blue;mso-fareast-language:FR">False</span></b><b><s=
pan lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&=
quot;;color:navy;mso-fareast-language:FR">)</span></b><span lang=3D"EN-US" =
style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:black;m=
so-fareast-language:FR"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:35.4pt;background:white"><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot=
;;color:black;mso-fareast-language:FR">&nbsp;&nbsp;&nbsp;
</span><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Cou=
rier New&quot;;color:green;mso-fareast-language:FR">#print(&quot;dsba: &quo=
t; &#43; dsba)</span><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-fa=
mily:&quot;Courier New&quot;;color:black;mso-fareast-language:FR"><o:p></o:=
p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:35.4pt;background:white"><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot=
;;color:black;mso-fareast-language:FR">&nbsp;&nbsp;&nbsp;
</span><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;=
Courier New&quot;;color:blue;mso-fareast-language:FR">return</span></b><spa=
n lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&qu=
ot;;color:black;mso-fareast-language:FR"> dsba&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:35.4pt;background:white"><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot=
;;color:black;mso-fareast-language:FR">FETCHCMD_git
</span><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;=
Courier New&quot;;color:navy;mso-fareast-language:FR">=3D</span></b><span l=
ang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;=
;color:black;mso-fareast-language:FR">
</span><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Cou=
rier New&quot;;color:gray;mso-fareast-language:FR">&quot;export DBUS_SESSIO=
N_BUS_ADDRESS=3D${@getDSBA(d)}; git -c core.fsyncobjectfiles=3D0&quot;</spa=
n><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Courier =
New&quot;;color:black;mso-fareast-language:FR"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-US" styl=
e=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:black;mso-f=
areast-language:FR"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif;color:#707070;mso-fareast-language:F=
R">Jo=EBl Esponde<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:9.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif;color:#707070;mso-fareast-language:FR=
">Honeywell
</span></b><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;=
Arial&quot;,sans-serif;color:#707070;mso-fareast-language:FR">| Sensing and=
 Productivity Solutions<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span style=3D"mso-fareast-language:FR">De&nbsp;:=
</span></b><span style=3D"mso-fareast-language:FR"> bitbake-devel-bounces@l=
ists.openembedded.org [mailto:bitbake-devel-bounces@lists.openembedded.org]
<b>De la part de</b> Esponde, Joel<br>
<b>Envoy=E9&nbsp;:</b> vendredi 22 avril 2016 11:38<br>
<b>=C0&nbsp;:</b> bitbake-devel@lists.openembedded.org<br>
<b>Objet&nbsp;:</b> [bitbake-devel] Fetcher issue: Error communicating with=
 gnome-keyring-daemon<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#400000">Hi,<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#400000"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">When bi=
tbake tries to fetch code from a git repository that needs authentication w=
hose credentials are stored in Gnome Keyring, it fails and produces this er=
ror:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; ** (process:53010): CRITICAL **: Error communicating with gnome=
-keyring-daemon<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; fatal: could not read Username for &#8216;https://git.someserve=
r.com&#8216;: No such device or address<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">git-cre=
dential-gnomekeyring is the helper used by git to store credentials in Gnom=
e Keyring.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">git-cre=
dential-gnomekeyring uses D-Bus to communicate with Gnome Keyring when X or=
 Gnome environment is not accessible (for example, through SSH).<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">Therefo=
re, *.bashrc* is modified like this during *git-credential-gnomekeyring* in=
stallation:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; # git-credential-gnome-keyring:
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;# If you are connected to your workstation via SSH, you'll=
 need to set up D-Bus,
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;# or else you'll get Error communicating with gnome-keyrin=
g-daemon.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;# The solution is to add the following to your .bashrc or =
.zshrc file:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; if [[ -z $DBUS_SESSION_BUS_ADDRESS ]]; then<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;if [[ -f ~/.dbus/session-bus/$(dbus-uui=
dgen --get)-0 ]]; then<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;source ~/.dbus/=
session-bus/$(dbus-uuidgen --get)-0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;export DBUS_SES=
SION_BUS_ADDRESS<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;fi<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp; fi<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">So one =
way to allow bitbake's fetcher access Gnome Keyring is to avoid DBUS_SESSIO=
N_BUS_ADDRESS variable being removed from bitbake's fetcher environment.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">This ca=
n be achieved in those two steps:
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo2"><![if !supportLists]><span lang=3D"EN-US" style=3D"color:#400000">=
<span style=3D"mso-list:Ignore">-<span style=3D"font:7.0pt &quot;Times New =
Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US" style=3D"color:#400000"=
>First, fetcher's code needs to stop filtering DBUS_SESSION_BUS_ADDRESS, he=
re is the fix:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">diff --=
git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">index b=
004dae..392e307 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">--- a/b=
itbake/lib/bb/fetch2/__init__.py<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&#43;&#=
43;&#43; b/bitbake/lib/bb/fetch2/__init__.py<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">@@ -784=
,7 &#43;784,8 @@ def runfetchcmd(cmd, d, quiet =3D False, cleanup =3D []):<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 'ALL_PROXY', 'all_proxy',<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 'GIT_PROXY_COMMAND',<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 'SSH_AUTH_SOCK', 'SSH_AGENT_PID',<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">-&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 'SOCKS5_USER', 'SOCKS5_PASSWD']<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&#43;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 'SOCKS5_USER', 'SOCKS5_PASSWD',<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&#43;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 'DBUS_SESSION_BUS_ADDRESS']<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;for var in exportvars:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D d.getVar(var, True)<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo2"><![if !supportLists]><span lang=3D"EN-US" style=3D"color:#400000">=
<span style=3D"mso-list:Ignore">-<span style=3D"font:7.0pt &quot;Times New =
Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US" style=3D"color:#400000"=
>Secondly, bitbake needs also to stop filtering DBUS_SESSION_BUS_ADDRESS th=
anks to its environment set like this:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">$ expor=
t BB_ENV_EXTRAWHITE=3D&quot;DBUS_SESSION_BUS_ADDRESS&quot;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">What do=
 you think about this fix?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000">My main=
 concern about this solution is that any user that would store his git&#821=
7;s credentials in Gnome Keyring would have to set BB_ENV_EXTRAWHITE before=
 being able to use bitbake&#8230; It does not look
 like very handy&#8230;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#400000"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Arial&quot;,sans-serif;color:#707070;mso-fareast-language:F=
R">Jo=EBl Esponde<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:9.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif;color:#707070;mso-fareast-language:FR=
">Honeywell
</span></b><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;=
Arial&quot;,sans-serif;color:#707070;mso-fareast-language:FR">| Sensing and=
 Productivity Solutions<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_F6CD090A69E64C4289DC608E1C5D2024253E0D02DE08W1305global_--
