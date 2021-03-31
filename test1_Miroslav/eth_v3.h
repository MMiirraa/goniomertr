

#define htons(a) ((((a)>>8)&0xff)|(((a)<<8)&0xff00))
#define ntohs(a) htons(a)
// perekodirovka dword'a
#define htonl(a)( (((a)>>24)&0xff) | (((a)>>8)&0xff00) |\
                  (((a)<<8)&0xff0000) | (((a)<<24)&0xff000000) )
#define ntohl(a) htonl(a)
// Makros for IP-adress
#define inet_addr(a,b,c,d)( ((uint32_t)a) | ((uint32_t)b << 8) |\
                            ((uint32_t)c << 16) | ((uint32_t)d << 24) )

#define ETH_TYPE_ARP htons(0x806)
#define ETH_TYPE_IP  htons(0x800)
#define ARP_HW_TYPE_ETH  htons(0x0001)
#define ARP_PROTO_TYPE_IP  htons(0x0800)
#define ARP_TYPE_REQUEST  htons(0x1)
#define ARP_TYPE_RESPONSE  htons(0x2)

// MAC-adress
uint8_t mac_addr[6] = {0x00,0x13,0x37,0x01,0x23,0x45};
// IP-adress
uint32_t ip_addr = inet_addr(192,168,0,222);

// Ethernet-fraim
typedef struct eth_frame{
	uint8_t to_adr[6] ;	// 
	uint8_t from_adr[6] ;
	uint16_t type ;
	uint8_t data[] ;
} eth_frame_t ;

// ARP-paket
typedef struct arp_message{
	uint16_t hw_type ;	// 
	uint16_t proto_type ;
	uint8_t hw_adr_len ;
	uint8_t proto_adr_len ;
	uint16_t type ;
	uint8_t mac_addr_from[6] ;
	uint32_t ip_adr_from ;
	uint8_t mac_addr_t0[6] ;
	uint32_t ip_adr_to ;
} arp_message_t ;

// otvet
void eth_reply(eth_frame_t *frame, uint16_t len)
{ memcpy(frame->to_adr, frame->from_adr, 6);
  memcpy(frame->from_adr, mac_adr, 6);
  send_Eth_packet((void*)frame, len + sizeof(eth_frame_t)); }

// obrabotchik ARP-paketov
void arp_filter(eth_frame_t *frame, uint16_t len)
{ arp_message_t *msg = (void*)(frame->data);
   if(len >= sizeof(arp_message_t))
	{ // proverjem tip protokola 
	 if( (msg->type == ARP_HW_TYPE_ETH) && (msg->proto_type == ARP_PROTO_TYPE_IP))
	   { // ARP-zaproc i nash adrec?
	     if( (msg->hw_type == ARP_TYPE_REQUEST) && (msg->ip_adr_to == ip_addr))
	      { // otvet
	        msg->type = ARP_TYPE_RESPONSE;
	        memcpy(msg->mac_addr_t0, msg->mac_addr_from, 6);
  		memcpy(msg->mac_addr_from, mac_adr, 6);
		msg->ip_adr_to = msd->ip_adr_from;
		msd->ip_adr_from = ip_addr;
		eth_replay(frame, sizeof(arp_message_t); }}}}

// obrabotchik paketov
void eth_filter(eth_frame_t *frame, uint16_t len)
{ if(len >= sizeof(eth_frame_t))
   { switch(frame_type)
     { case ETH_TYPE_ARP:
				arp_filter(frame, len - sizeof(eth_frame_t)); break;
			 case ETH_TYPE_IP:
				ip_filter(frame, len - sizeof(eth_frame_t)); break; }
		}
}

 